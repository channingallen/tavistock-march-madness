class Api::UsersController < ApplicationController

  # GET /users
  def index
    conditions = []
    if params[:ids] and params[:ids].class == Array
      conditions = ["id IN (?)", params[:ids].collect { |id| id.to_i }]
    elsif params[:fb_id]
      conditions = ["fb_id = ?", params[:fb_id]]
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
    user[:fb_id] = params[:user][:fb_id]
    user[:fb_username] = params[:user][:fb_username]
    user[:fb_access_token] = params[:user][:fb_access_token]
    user[:name] = params[:user][:name]
    user[:email] = params[:user][:email]
    user[:gender] = params[:user][:gender]
    user[:timezone] = params[:user][:timezone]
    user.save

    render :json => user
  end

  # PUT /users/:id
  def update
    user = User.find_by_id(params[:id])
    user[:fb_id] = params[:user][:fb_id]
    user[:fb_username] = params[:user][:fb_username]
    user[:fb_access_token] = params[:user][:fb_access_token]
    user[:name] = params[:user][:name]
    user[:email] = params[:user][:email]
    user[:gender] = params[:user][:gender]
    user[:timezone] = params[:user][:timezone]
    user.save

    render :json => user
  end
end