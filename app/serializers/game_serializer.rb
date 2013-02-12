class GameSerializer < ActiveModel::Serializer
  attributes :id,
             :team_one,
             :team_two,
             :winning_team,
             :next_game

  def team_one
    object.team_one_id
  end

  def team_two
    object.team_one_id
  end

  def winning_team
    object.winning_team_id
  end

  def next_game
    object.next_game_id
  end

  has_one :bracket, :embed => :ids

end