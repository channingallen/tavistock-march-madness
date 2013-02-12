class Api::GamesController < ApplicationController

  # PUT /games/:id
  def update
    game = Game.find_by_id(params[:id])
    game[:team_one_id] = params[:team_one_id]
    game[:team_two_id] = params[:team_two_id]
    game.save

    render :json => game
  end

end