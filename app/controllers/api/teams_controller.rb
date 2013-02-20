class Api::TeamsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # GET /teams
  def index
    conditions = []
    if params[:ids] and params[:ids].class == Array
      conditions = ["id IN (?)", params[:ids].collect { |id| id.to_i }]
    end
    teams = Team.where(conditions)

    render :json => teams
  end

  # GET /teams/:id
  def show
    team = Team.find_by_id(params[:id])

    render :json => team
  end

end