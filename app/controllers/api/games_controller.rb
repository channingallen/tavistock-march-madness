class Api::GamesController < ApplicationController

  skip_before_filter :verify_authenticity_token

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
    return if Constants::PHASE == "preparation"

    game = Game.find_by_id(params[:id])
    bracket = game.bracket
    bad_official_edit = (Constants::PHASE != "tournament" and
                         Constants::PHASE != "testing" and
                         bracket[:is_official])
    bad_unofficial_edit = (Constants::PHASE != "selection" and
                           Constants::PHASE != "testing" and
                           !bracket[:is_official])
    return if (bad_official_edit or bad_unofficial_edit)

    game[:team_one_id] = params[:game][:team_one_id]
    game[:team_two_id] = params[:game][:team_two_id]
    game[:winning_team_id] = params[:game][:winning_team_id]
    game.save

    render :json => game
  end

end