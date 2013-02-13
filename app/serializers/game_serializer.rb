class GameSerializer < ActiveModel::Serializer
  attributes :id,
             :team_one_id,
             :team_two_id,
             :winning_team_id,
             :next_game_id,
             :bracket_id
end