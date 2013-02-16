class Api::UsersController < ApplicationController

  # GET /users
  def index
    conditions = []
    if params[:ids] and params[:ids].class == Array
      conditions = ["id IN (?)", params[:ids].collect { |id| id.to_i }]
    end
    users = User.where(conditions).to_a

    render :json => users
  end

  # GET /users/:id
  def show
    user = User.find_by_id(params[:id])

    render :json => user
  end

  # POST /users
  def create
    user = User.new
    user[:name] = params[:user][:name]
    user[:email] = params[:user][:email]
    user.save

    render :json =>  user
  end

  # DELETE /users/:id
  def destroy
    user = User.find_by_id(params[:id])
    user.destroy

    render :json => user
  end

end