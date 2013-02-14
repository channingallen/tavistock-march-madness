class Game < ActiveRecord::Base

  attr_accessible :bracket_id, :team_one_id, :team_two_id, :winning_team_id,
                  :next_game_id, :score


  #################
  #   Constants   #
  #################

  POINTS_PER_WIN_BY_ROUND = {
    1 => 0, # First Four (not supported, therefore 0 points)
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

  belongs_to :bracket
  has_one :user, :through => :bracket


  ###################
  #   Validations   #
  ###################

  validates :score, :length => { :minimum => 0 }
  validates :bracket_id, :presence => true
  validate :validate_bracket_id
  validate :validate_team_one_id
  validate :validate_team_two_id
  validate :validate_winning_team_id
  validate :validate_next_game_id

  private

  # Ensure the game's bracket_id attribute corresponds to an extant bracket.
  def validate_bracket_id
    unless Bracket.first({ :conditions => ["id = ?", self[:bracket_id]] })
      errors.add(:bracket_id, "must refer to existing record")
    end
  end

  # Ensure the team_one_id attribute corresponds to an existing team, and that
  # that team won one of the previous games.
  def validate_team_one_id
    return if self[:team_one_id].nil?

    team = Team.first({ :conditions => ["id = ?", self[:team_one_id]] })
    if team.nil?
      errors.add(:team_one_id, "must refer to existing record")
    end

    previous_games = Game.all(:conditions => ["next_game_id = ?", self[:id]])
    unless previous_games.empty?
      matching_game = previous_games.detect do |previous_game|
        previous_game[:winning_team_id] == self[:team_one_id]
      end
      unless matching_game
        errors.add(:team_one_id, "must have won one of the previous games")
      end
    end
  end

  # Ensure the team_two_id attribute corresponds to an existing team, and that
  # that team won one of the previous games.
  def validate_team_two_id
    return if self[:team_two_id].nil?

    team = Team.first({ :conditions => ["id = ?", self[:team_two_id]] })
    if team.nil?
      errors.add(:team_two_id, "must refer to existing record")
    end

    previous_games = Game.all(:conditions => ["next_game_id = ?", self[:id]])
    unless previous_games.empty?
      matching_game = previous_games.detect do |previous_game|
        previous_game[:winning_team_id] == self[:team_two_id]
      end
      unless matching_game
        errors.add(:team_two_id, "must have won one of the previous games")
      end
    end
  end

  # Ensure the winning_team_id attribute corresponds to an existing team, and
  # that it matches either the team_one_id or team_two_id.
  def validate_winning_team_id
    return if self[:winning_team_id].nil?
    
    team = Team.first({ :conditions => ["id = ?", self[:winning_team_id]] })
    if team.nil?
      errors.add(:winning_team_id, "must refer to existing record")
    end
    
    unless [self.team_one_id, self.team_two_id].include?(self.winning_team_id)
      errors.add(:winning_team_id, "must have participated in this game")
    end
  end

  # Ensure the next_game_id attribute corresponds to an existing game in the
  # same bracket.
  def validate_next_game_id
    return if self[:next_game_id].nil?

    game = Game.first({ :conditions => ["id = ?", self[:next_game_id]] })
    if game.nil?
      errors.add(:next_game_id, "must refer to existing record")
    end

    unless game[:bracket_id] == self.bracket_id
      errors.add(:next_game_id, "must refer to a game in the same bracket")
    end
  end


  #################
  #   Callbacks   #
  #################

  after_update :update_scores

  private

  def update_scores
    return unless self.bracket[:is_official]
    return unless self[:winning_team_id]

    Game.award_points_for_win({
      :winning_team_id => self[:winning_team_id],
      :round_number => self.round_number
    })
  end


  ###############
  #   Methods   #
  ###############

  public

  # Figures out which round the game belongs to. Note that we're counting the
  # First Four as round #1, then the ro64 is round #2, etc, until the finals
  # which is round #7.
  def round_number
    round_num = 2
    previous_game = Game.first(:conditions => ["next_game_id = ?", self[:id]])
    while previous_game
      round_num += 1
      conditions = ["next_game_id = ?", previous_game[:id]]
      previous_game = Game.first(:conditions => conditions)
    end

    round_num
  end

  def self.award_points_for_win(options)
    raise "invalid team" unless Team.exists?(options[:winning_team_id])
    num_points = Game::POINTS_PER_WIN_BY_ROUND[options[:round_number]]

    # For each user's bracket...
    Bracket.all(:select => "id").each do |bracket|

      # ...we find every game in which the appropriate team is the winner.
      conditions = ["bracket_id = ? AND winning_team_id = ?",
                    bracket[:id],
                    options[:winning_team_id]]
      potential_matching_games = Game.all(:conditions => conditions)

      # We then narrow this list down to whichever game occurred in the
      # appropriate round.
      matching_game = potential_matching_games.detect do |game|
        game.round_number == options[:round_number]
      end

      # If a matching game was found, we award the points.
      if matching_game
        matching_game.update_attributes! :score => num_points
      end
    end
  end

end
