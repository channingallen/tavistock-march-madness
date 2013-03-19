require 'net/http'
require 'net/https'

class User < ActiveRecord::Base

  attr_accessible :name, :email, :fb_id, :gender, :timezone, :fb_username,
                  :fb_access_token, :phone, :restaurant_id, :contact_allowed,
                  :restaurant_location, :score


  ####################
  #   Associations   #
  ####################

  has_one :bracket, :dependent => :destroy
  has_many :games, :through => :bracket


  ###################
  #   Validations   #
  ###################

  validates :email, :uniqueness => true, :allow_nil => true
  validates :score, :numericality => { :greater_than_or_equal_to => 0 }
  validates :fb_id, :uniqueness => true, :allow_nil => true
  validates :fb_username, :uniqueness => true, :allow_nil => true
  validates :fb_access_token, :uniqueness => true, :allow_nil => true
  validates :name, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :phone, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :email, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :fb_id, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :gender, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :timezone, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :fb_username, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :restaurant_id, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :fb_access_token, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :restaurant_location, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true

  #################
  #   Callbacks   #
  #################

  after_create :build_bracket

  def build_bracket
    bracket = Bracket.new
    bracket.user_id = self[:id]
    bracket.save
  end

  ###############
  #   Methods   #
  ###############

  def extend_access_token
    params = {
      :grant_type => "fb_exchange_token",
      :client_id => Constants::FB_APP_ID,
      :client_secret => Constants::FB_APP_SECRET,
      :fb_exchange_token => self.fb_access_token
    }
    url = "https://graph.facebook.com/oauth/access_token"
    uri = URI.parse(URI.encode(url))
    path_with_params = uri.path + "?" + CGI.unescape(params.to_query)

    request = Net::HTTP::Get.new(path_with_params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)

    if response.code == "200"
      response.body.split("&").each do |part|
        index = part.index("access_token=")
        if index
          new_token = part[("access_token=".length + index)..part.length]
          self.fb_access_token = new_token
          self.save!
          return
        end
      end
      raise "no access token found in response body: #{response.body}"
    else
      raise "#{response.code} - #{response.body}"
    end
  end

  def notify(template)
    raise "must specify template" if template.blank?

    uri = URI.parse(URI.encode(url))
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(:access_token => Constants::FB_APP_ACCESS_TOKEN,
                          :template => template,
                          :href => "")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.request(request)
  end

  def update_score!(official_games_by_round = nil)

    # Prepare the list of official games by organizing them by round.
    unless official_games_by_round
      official_games = Bracket.where(:is_official => true).first.games
      official_games_by_round = official_games.inject({}) do |hash, game|
        game_round_number = game.round_number
        if hash[game_round_number]
          hash[game_round_number] << game
        else
          hash[game_round_number] = [game]
        end
        hash
      end
    end

    # Prepare the list of the user's games by organizing them by round.
    user_games_by_round = self.games.inject({}) do |hash, game|
      game_round_number = game.round_number
      if hash[game_round_number]
        hash[game_round_number] << game
      else
        hash[game_round_number] = [game]
      end
      hash
    end

    # Assign scores to the user's games.
    # For each game in each round...
    valid_team_ids = Team.select(:id).map { |t| t.id }
    user_games_by_round.each_pair do |round_number, games|
      games.each do |game|

        # ...determine whether or not the correct prediction was made.
        correct_pick = false
        predicted_winner_id = game[:winning_team_id]
        if valid_team_ids.include? predicted_winner_id
          official_games_by_round[round_number].each do |official_game|
            if official_game[:winning_team_id] == predicted_winner_id
              correct_pick = true
              break
            end
          end
        end
        score = correct_pick ? Bracket::POINTS_PER_WIN_BY_ROUND[round_number] : 0
        game.update_attributes! :score => score
      end
    end

    # Calculate the total score and update the user object itself.
    self.update_attributes! :score => self.games.map { |game| game[:score] }.sum
  end

  def self.update_all_scores
    logfile = File.open("#{Rails.root}/log/whenever.log", 'a')
    logfile.sync = true
    logger = Logger.new(logfile)
    logger.info "\n\n#{Time.now.iso8601}\nUpdating all user scores..."

    official_games = Bracket.where(:is_official => true).first.games
    official_games_by_round = official_games.inject({}) do |hash, game|
      game_round_number = game.round_number
      if hash[game_round_number]
        hash[game_round_number] << game
      else
        hash[game_round_number] = [game]
      end
      hash
    end

    User.all.each do |user|
      user.update_score!(official_games_by_round)
      logger.info "   #{user.email} (#{user.id}) - #{user.score} points"
    end
  end

  def self.counts
    total = User.count
    num_filled_out_form = User.where("email IS NOT NULL AND name IS NOT NULL AND phone IS NOT NULL").size
    num_started_bracket = Game.where("winning_team_id IS NOT NULL").select("DISTINCT(bracket_id)").size
    num_finished_bracket = total - Game.where("winning_team_id IS NULL AND next_game_id IS NOT NULL").select("DISTINCT(bracket_id)").size

    puts "\n********************************************************\n"
    puts "Num Total Signups:    #{total}"
    puts "Num Filled Out Form:  #{num_filled_out_form} (#{(100*num_filled_out_form/total.to_f).round}%)"
    puts "Num Started Bracket:  #{num_started_bracket} (#{(100*num_started_bracket/total.to_f).round}%)"
    puts "Num Finished Bracket: #{num_finished_bracket} (#{(100*num_finished_bracket/total.to_f).round}%)"
    puts "\n********************************************************\n\n"
  end

end
