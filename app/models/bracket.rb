class Bracket < ActiveRecord::Base

  attr_accessible :is_official, :user_id


  #################
  #   Constants   #
  #################

  NUM_TEAMS = 64
  NUM_GAMES = 63

  ####################
  #   Associations   #
  ####################

  belongs_to :user
  has_many :games, :dependent => :destroy

  ###################
  #   Validations   #
  ###################

  validate :validate_user_id

  # Ensure the user_id attribute corresponds to an existing user.
  def validate_user_id
    user = User.first({ :conditions => "id = #{self[:user_id]}" })

    if user == nil
      errors.add(:user_id, "No such user exists.")
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
    game_ids = []
    Bracket::NUM_GAMES.times do
      game = Game.new
      game[:bracket_id] = self[:id]
      game.save
      game_ids.push(game[:id])
    end

    # Organize the games into rounds.
    rounds = create_rounds(game_ids)

    # Set the next_game_id attributes.
    set_next_game_ids(rounds)
  end

  # Organize the games into rounds.
  def create_rounds(game_ids)
    rounds = []
    round = []
    current_game_index = 0
    num_games_in_round = (Bracket::NUM_TEAMS / 2) 
    final_game_index = current_game_index + (num_games_in_round - 1)
       
    while num_games_in_round >= 1
      current_game_index.upto(final_game_index) do |game_index|
        round.push(game_ids[game_index])
      end
      rounds.push(round)
      round = []
      num_games_in_round /= 2
      current_game_index = final_game_index + 1
      final_game_index = current_game_index + (num_games_in_round - 1)
    end
    rounds
  end

  # Set the set_next_game_id attributes.
  def set_next_game_ids(rounds)
    rounds.each_with_index do |round, round_index|
      unless round.length == 1
        next_round = rounds[round_index + 1]
        num_iterations = 0
        next_game_index = 0
        round.each_with_index do |game_id, game_id_index|
          game = Game.first({ :conditions => "id = #{game_id}" })
          game[:next_game_id] = next_round[next_game_index]
          game.save
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

  # TODO: put methods here

end
