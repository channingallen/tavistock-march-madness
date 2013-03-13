class Bracket < ActiveRecord::Base

  attr_accessible :is_official, :user_id


  #################
  #   Constants   #
  #################

  NUM_TEAMS = 64
  NUM_GAMES = 67
  POINTS_PER_WIN_BY_ROUND = {
    1 => 1, # First Four
    2 => 1, # Round of 64
    3 => 2, # Round of 32
    4 => 3, # Sweet Sixteen
    5 => 4, # Elite Eight
    6 => 6, # Final Four
    7 => 10, # Finals
  }

  ####################
  #   Associations   #
  ####################

  belongs_to :user
  has_many :games, :dependent => :destroy

  ###################
  #   Validations   #
  ###################

  validate :validate_user_id
  validate :validate_is_official, :on => :create

  # Ensure the user_id attribute corresponds to an existing user.
  def validate_user_id

    # The official bracket doesn't belong to anyone.
    return if self[:is_official]

    user = User.first({ :conditions => ["id = ?", self[:user_id]] })
    if user.nil?
      errors.add(:user_id, "must refer to existing record")
    end
  end

  # Ensures there can only be one official bracket.
  def validate_is_official
    if (self[:is_official] and 
        Bracket.count(:conditions => "is_official = TRUE") > 0)
      errors.add(:is_official, "the offical bracket already exists")
    end
  end

  #################
  #   Callbacks   #
  #################

  after_create :set_up_bracket

  # Creates 63 games for the bracket, then organizes the games into
  # a 64-man tournament by setting their next_game_id attributes.
  def set_up_bracket

    # Create the games.
    games = create_bracket_games

    # Organize the games into rounds.
    game_ids = games.collect { |game| game[:id] }
    rounds = create_rounds(game_ids)

    # Set the next_game_id attributes.
    set_next_game_ids(rounds)
  end

  # Creates games for the brackets, and sets their team id attrs.
  def create_bracket_games
    official_games = []
    unless self[:is_official]
      official_bracket_id = Bracket.first({
        :conditions => "is_official IS TRUE",
        :select => "id"
      })[:id]
      official_games = Game.all({
        :conditions => ["bracket_id = ?", official_bracket_id],
        :select => "team_one_id, team_two_id",
        :order => "id ASC"
      })
    end

    games = []
    Bracket::NUM_GAMES.times do |index|
      game = Game.new
      game[:bracket_id] = self[:id]
      unless official_games.empty?
        game[:team_one_id] = official_games[index][:team_one_id]
        game[:team_two_id] = official_games[index][:team_two_id]
      end
      game.save!
      games.push(game)
    end

    games
  end

  # Organize the games into rounds.
  def create_rounds(game_ids)
    rounds = [[game_ids[game_ids.length - 4],
               game_ids[game_ids.length - 3],
               game_ids[game_ids.length - 2],
               game_ids[game_ids.length - 1]]]

    current_game_index = 0
    num_games_in_round = Bracket::NUM_TEAMS / 2
    final_game_index = current_game_index + (num_games_in_round - 1)
    while num_games_in_round >= 1
      rounds.push([])
      current_game_index.upto(final_game_index) do |game_index|
        rounds.last.push(game_ids[game_index])
      end
      num_games_in_round /= 2
      current_game_index = final_game_index + 1
      final_game_index = current_game_index + (num_games_in_round - 1)
    end

    rounds
  end

  # Set the set_next_game_id attributes.
  def set_next_game_ids(rounds)
    rounds[0].each_with_index do |game_id, index|
      game = Game.first({ :conditions => ["id = ?", game_id] })
      game.update_attributes! :next_game_id => rounds[1][index * 8]
    end

    rounds.each_with_index do |round, round_index|
      next if round_index == 0
      unless round.length == 1
        next_round = rounds[round_index + 1]
        num_iterations = 0
        next_game_index = 0
        round.each do |game_id|
          game = Game.first({ :conditions => ["id = ?", game_id] })
          game.update_attributes! :next_game_id => next_round[next_game_index]
          num_iterations += 1
          if num_iterations == 2
            next_game_index += 1
            num_iterations = 0
          end
        end
      end
    end
  end

  ###############
  #   Methods   #
  ###############

  # ...

end
