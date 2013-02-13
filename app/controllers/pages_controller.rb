class PagesController < ApplicationController

  def index
    user = User.first
    bracket = user.bracket
    games = bracket.games
    teams = Team.all

    @json_data = {
      :user => UserSerializer.new(user).as_json[:user],
      :bracket => BracketSerializer.new(bracket).as_json[:bracket],
      :games => ActiveModel::ArraySerializer.new(games).as_json,
      :teams => ActiveModel::ArraySerializer.new(teams).as_json
    }.to_json
  end

end