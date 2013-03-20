class Game < ActiveRecord::Base

  attr_accessible :bracket_id, :team_one_id, :team_two_id, :winning_team_id,
                  :next_game_id, :score


  #################
  #   Constants   #
  #################

  # ...


  ####################
  #   Associations   #
  ####################

  belongs_to :bracket, :touch => true
  has_one    :user, :through => :bracket
  belongs_to :next_game, :class_name => "Game"
  has_many   :previous_games, :foreign_key => "next_game_id", :order => "id ASC", :class_name => "Game"
  belongs_to :team_one, :class_name => "Team"
  belongs_to :team_two, :class_name => "Team"


  ###################
  #   Validations   #
  ###################

  validates :score, :numericality => { :greater_than_or_equal_to => 0 }
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

  def validate_team_one_id
    return if self[:team_one_id].nil?

    team = Team.first({ :conditions => ["id = ?", self[:team_one_id]] })
    if team.nil?
      errors.add(:team_one_id, "must refer to existing record")
    end
  end

  def validate_team_two_id
    return if self[:team_two_id].nil?

    team = Team.first({ :conditions => ["id = ?", self[:team_two_id]] })
    if team.nil?
      errors.add(:team_two_id, "must refer to existing record")
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

    team_ids = [self[:team_one_id], self[:team_two_id]]
    unless team_ids.include?(self[:winning_team_id])
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

    unless game[:bracket_id] == self[:bracket_id]
      errors.add(:next_game_id, "must refer to a game in the same bracket")
    end
  end


  #################
  #   Callbacks   #
  #################

  before_validation :nullify_winning_team
  after_update :update_teams_for_later_games

  private

  # Changes the winning_team_id to null unless it matches team_one_id or
  # team_two_id.
  def nullify_winning_team
    return if self[:winning_team_id].nil?
    team_ids = [self[:team_one_id], self[:team_two_id]]
    return if team_ids.include?(self[:winning_team_id])

    self[:winning_team_id] = nil
  end

  # Updates the next game's team_one_id or team_two_id based on the winner of
  # this game.
  #
  # Note that this will run recursively, because it's called after updating a
  # game and it itself updates games.
  def update_teams_for_later_games
    return unless self[:next_game_id]
    
    sibling_game = self.sibling_game
    return unless (sibling_game or self.round_number == 1)

    team_attr = sibling_game ?
                (self[:id] < sibling_game[:id] ? :team_one_id : :team_two_id) :
                :team_two_id
    next_game = self.next_game
    unless (next_game[team_attr] == self[:winning_team_id])
      next_game.update_attributes!(team_attr => self[:winning_team_id])
    end
  end

  ###############
  #   Methods   #
  ###############

  public

  # Returns the other game that shares a next_game_id with a current game. For
  # example of the winners of game 1 and game 2 play against each other in game
  # 3, then game 1 is the sibling of game 2 and vice versa.
  def sibling_game
    return nil if self[:next_game_id].nil?

    conds = ["id <> ? AND next_game_id = ?", self[:id], self[:next_game_id]]
    Game.first(:conditions => conds, :select => "id")
  end

  # Figures out which round the game belongs to. Note that we're counting the
  # First Four as round #1, then the ro64 is round #2, etc, until the finals,
  # which is round #7.
  def round_number
    position = Game.where(['bracket_id = ? AND id < ?', self.bracket_id, self.id]).size
    if position < 32
       2
    elsif position < 48
       3
    elsif position < 56
       4
    elsif position < 60
       5
    elsif position < 62
       6
    elsif position < 63
       7
    else
       1
    end
  end

  def old_round_number
    round_num = 7
    next_game = Game.where(:id => self.next_game_id).select('next_game_id').first
    while next_game
      round_num -= 1
      break unless next_game.next_game_id
      conds = { :id => next_game.next_game_id }
      next_game = Game.where(conds).select('next_game_id').first
    end

    round_num
  end

end
