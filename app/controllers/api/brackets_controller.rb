class Api::BracketsController < ApplicationController

  # GET /brackets/:id
  def show
    bracket = Bracket.find_by_id(params[:id])

    render :json => bracket
  end

end