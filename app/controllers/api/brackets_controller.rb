class Api::BracketsController < ApplicationController

  # GET /brackets
  def index
    conditions = []
    if params[:ids] and params[:ids].class == Array
      conditions = ["id IN (?)", params[:ids].collect { |id| id.to_i }]
    end
    brackets = Bracket.where(conditions)

    render :json => brackets
  end

  # GET /brackets/:id
  def show
    bracket = Bracket.find_by_id(params[:id])

    render :json => bracket
  end

end