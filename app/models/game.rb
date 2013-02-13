class Game < ActiveRecord::Base

  attr_accessible :bracket_id, :team_one_id, :team_two_id, :winning_team_id,
                  :next_game_id

  ####################
  #   Associations   #
  ####################

  belongs_to :bracket

  ###################
  #   Validations   #
  ###################

  validates :bracket_id, :presence => true
  validate :validate_bracket_id
  validate :validate_team_one_id
  validate :validate_team_two_id
  validate :validate_winning_team_id
  validate :validate_next_game_id

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

  # TODO: put callbacks here


  ###############
  #   Methods   #
  ###############

  # TODO: put methods here

end
