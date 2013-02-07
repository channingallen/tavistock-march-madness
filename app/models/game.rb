class Game < ActiveRecord::Base
  attr_accessible :next_game_id, :team_one_id, :team_two_id, :winning_team_id
end
