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

  validate :validate_bracket_id
  validate :validate_team_one_id
  validate :validate_team_two_id
  validate :validate_winning_team_id
  validate :validate_next_game_id

  # Ensure the bracket_id attribute corresponds to an existing user.
  def validate_bracket_id
    user = User.first({ :conditions => "id = #{self[:bracket_id]}" })

    if user == nil
      errors.add(:bracket_id, "No such user exists.")
    end
  end

  # Ensure the team_one_id attribute corresponds to an existing team if the
  # t1id != nil.
  def validate_team_one_id
    unless self[:team_one_id].nil?
      team = Team.first({ :conditions => "id = #{self[:team_one_id]}" })

      if team.nil?
        errors.add(:team_one_id, "This team does not exist.")
      end
    end
  end

  # Ensure the team_two_id attribute corresponds to an existing team.
  def validate_team_two_id
    unless self[:team_two_id].nil?
      team = Team.first({ :conditions => "id = #{self[:team_two_id]}" })

      if team.nil?
        errors.add(:team_two_id, "This team does not exist.")
      end
    end
  end

  # Ensure the winning_team_id attribute corresponds to an existing team.
  def validate_winning_team_id
    unless self[:winning_team_id].nil?
      team = Team.first({ :conditions => "id = #{self[:winning_team_id]}" })

      if team.nil?
        errors.add(:winning_team_id, "This team does not exist.")
      end
    end
  end

  # Ensure the next_game_id attribute corresponds to an existing game.
  def validate_next_game_id
    unless self[:next_game_id].nil?
      game = Game.first({ :conditions => "id = #{self[:next_game_id]}" })

      if game.nil?
        errors.add(:next_game_id, "This game could not be found.")
      end
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
