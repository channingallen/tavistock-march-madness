class Api::GamesController < ApplicationController

  # GET /game
  def index
    conditions = []
    if params[:ids] and params[:ids].class == Array
      conditions = ["id IN (?)", params[:ids].collect { |id| id.to_i }]
    end
    games = Game.where(conditions).to_a

    render :json => games
  end

  # GET /games/:id
  def show
    game = Game.find_by_id(params[:id])

    render :json => game
  end

  # PUT /games/:id
  def update
    game = Game.find_by_id(params[:id])
    game[:team_one_id] = params[:team_one_id]
    game[:team_two_id] = params[:team_two_id]
    game.save

    render :json => game
  end

end