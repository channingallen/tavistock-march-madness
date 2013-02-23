class Api::BracketsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # GET /brackets
  def index

    # custom conditions
    str_arr = []
    conditions = []
    if params[:ids] and params[:ids].class == Array
      str_arr.push("id IN (?)")
      conditions.push(params[:ids].collect { |id| id.to_i })
    end
    if params[:is_official]
      str_arr.push("is_official = TRUE")
    end
    conditions.prepend(str_arr.join(" AND "))

    brackets = Bracket.where(conditions)

    render :json => brackets
  end

  # GET /brackets/:id
  def show
    bracket = Bracket.find_by_id(params[:id])

    render :json => bracket
  end

end