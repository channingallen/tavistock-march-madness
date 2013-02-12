class Api::TeamsController < ApplicationController

  # GET /teams
  def index
    conditions = []
    if params[:ids] and params[:ids].class == Array
      conditions = ["id IN (?)", params[:ids].collect { |id| id.to_i }]
    end
    teams = Team.where(conditions)

    render :json => teams
  end

end