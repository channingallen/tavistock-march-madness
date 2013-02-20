class GameSerializer < ActiveModel::Serializer
  attributes :id,
             :score,
             :round_number,
             :team_one_id,
             :team_two_id,
             :winning_team_id,
             :next_game_id,
             :sibling_game_id,
             :bracket_id

  def round_number
    object.round_number
  end

  def sibling_game_id
    sibling_game = object.sibling_game
    sibling_game ? sibling_game[:id] : nil
  end

  has_many :previous_games, :embed => :ids
end