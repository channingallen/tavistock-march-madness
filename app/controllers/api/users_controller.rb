class Api::UsersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # GET /users
  def index

    # Custom conditions?
    conditions = []
    if params[:ids] and params[:ids].class == Array
      conditions = ["id IN (?)", params[:ids].collect { |id| id.to_i }]
    elsif params[:fb_id]
      if params[:fb_id].class == String
        conditions = ["fb_id = ?", params[:fb_id]]
      elsif params[:fb_id].class == Array
        conditions = ["fb_id IN (?)", params[:fb_id]]
      end
    end

    # Custom order?
    sort_property = "id"
    sort_direction = "ASC"
    if params[:sort] and User.column_names.include?(params[:sort].downcase)
      sort_property = params[:sort].downcase
    end
    if params[:order] and ["ASC", "DESC"].include?(params[:order].upcase)
      sort_direction = params[:order].upcase
    end
    order = "#{sort_property} #{sort_direction}"

    # Custom limit?
    limit = params[:limit] ? params[:limit].to_i : User.count

    # Special parameters?
    if params[:near_user]
      user = User.find_by_id(params[:near_user])
      users = []
      users += User.
        where(["id <> ? AND score <= ?", user[:id], user[:score]]).
        order("score DESC").
        limit(6)
      users.push(user)
      users += User.
        where(["id <> ? AND score > ?", user[:id], user[:score]]).
        order("score ASC").
        limit(9)

    # Normal request.
    else
      users = User.where(conditions).order(order).limit(limit).to_a
    end

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
    user[:phone] = params[:user][:phone]
    user[:restaurant_id] = params[:user][:restaurant_id]
    user[:contact_allowed] = params[:user][:contact_allowed]
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
    user[:phone] = params[:user][:phone]
    user[:restaurant_id] = params[:user][:restaurant_id]
    user[:contact_allowed] = params[:user][:contact_allowed]
    user.save

    render :json => user
  end
end