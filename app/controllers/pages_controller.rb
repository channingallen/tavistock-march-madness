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

  def channel
    expires_in 1.year, :public => true
    one_year = Time.now.advance(:years => 1)
    response.headers["Expires"] = one_year.strftime("%a, %d %b %Y %H:%M:%S GMT")
    response.headers["Pragma"] = "public"

    text = "<script src=\"//connect.facebook.net/en_US/all.js\"></script>"
    render :text => text
  end

end