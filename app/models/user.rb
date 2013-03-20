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

    url = "https://graph.facebook.com/#{self.fb_id}/notifications"
    uri = URI.parse(URI.encode(url))
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(:access_token => Constants::FB_APP_ACCESS_TOKEN,
                          :template => template,
                          :href => "")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.request(request)
  end

  def update_score!(valid_team_ids, official_games_by_round = nil)

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
    game_id_score_mappings = {}
    user_games_by_round.each_pair do |round_number, games|
      games.each do |game|

        # ...determine whether or not the correct prediction was made.
        correct_pick = false
        predicted_winner_id = game.winning_team_id
        if valid_team_ids.include? predicted_winner_id
          official_games_by_round[round_number].each do |official_game|
            if official_game.winning_team_id == predicted_winner_id
              correct_pick = true
              break
            end
          end
        end
        score = correct_pick ? Bracket::POINTS_PER_WIN_BY_ROUND[round_number] : 0
        unless game.score == score
          game_id_score_mappings[game.id] = score
        end
      end
    end
    Game.transaction do
      time_string = Time.now.to_s(:db)
      game_id_score_mappings.each_pair do |game_id, new_score|
        next unless (game_id and new_score)
        sql = "UPDATE `games` SET `score` = #{new_score}, " +
              "`updated_at` = '#{time_string}' WHERE `games`.`id` = #{game_id}"
        Game.connection.execute(sql)
      end
    end

    # Calculate the total score and update the user object itself.
    total_score = self.games.select('games.score').map { |g| g.score }.sum
    self.update_attributes! :score => total_score
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

    valid_team_ids = Team.select(:id).map { |t| t.id }
    User.all.each do |user|
      user.update_score!(valid_team_ids, official_games_by_round)
      logger.info "   #{user.email} (#{user.id}) - #{user.score} points"
    end
  end

  def self.counts
    def get_restaurant_count(restaurant, location = nil)
      return "" unless restaurant
      restaurant_conditions = { :restaurant_id => restaurant[:id], :restaurant_location => location }
      total = User.where(restaurant_conditions).size

      num_filled_out_form = User.where(restaurant_conditions).where("email IS NOT NULL AND name IS NOT NULL AND phone IS NOT NULL").size
      num_filled_out_form_pct = total == 0 ? 0 : (100*num_filled_out_form/total.to_f).round

      user_ids = User.where(restaurant_conditions).select("id").map { |u| u.id }
      bracket_ids = Bracket.where(["user_id IN (?)", user_ids]).select("id").map { |b| b.id }
      bracket_ids_condition = ["bracket_id IN (?)", bracket_ids]
      num_started_bracket = Game.where(bracket_ids_condition).where("winning_team_id IS NOT NULL").select("DISTINCT(bracket_id)").size
      num_started_bracket_pct = total == 0 ? 0 : (100*num_started_bracket/total.to_f).round

      num_finished_bracket = total - Game.where(bracket_ids_condition).where("winning_team_id IS NULL").select("DISTINCT(bracket_id)").size
      num_finished_bracket_pct = total == 0 ? 0 : (100*num_finished_bracket/total.to_f).round

      "\n#{restaurant[:name]}#{location ? " (#{location})" : ""}:" +
        "\nNum Total Signups:    #{total}" +
        "\nNum Filled Out Form:  #{num_filled_out_form} (#{num_filled_out_form_pct}%)" +
        "\nNum Started Bracket:  #{num_started_bracket} (#{num_started_bracket_pct}%)" +
        "\nNum Finished Bracket: #{num_finished_bracket} (#{num_finished_bracket_pct}%)"
    end

    counts = []
    restaurant_ids = User.select("DISTINCT(restaurant_id)").map { |u| u.restaurant_id }
    restaurant_ids.each do |restaurant_id|
      restaurant = Constants::RESTAURANTS[restaurant_id]
      if restaurant and restaurant[:locations] and !restaurant[:locations].empty?
        restaurant[:locations].each do |location|
          counts << get_restaurant_count(restaurant, location)
        end
      else
        counts << get_restaurant_count(restaurant)
      end
    end

    puts counts.join("\n")
  end

end
