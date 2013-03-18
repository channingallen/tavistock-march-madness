class Api::UsersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # GET /users
  def index

    # Custom conditions?
    str_arr = []
    conditions = []
    if params[:ids] and params[:ids].class == Array
      str_arr.push("id IN (?)")
      conditions.push(params[:ids].collect { |id| id.to_i })
    end
    if params[:fb_id]
      if params[:fb_id].class == String
        str_arr.push("fb_id = ?")
        conditions.push(params[:fb_id])
      elsif params[:fb_id].class == Array
        str_arr.push("fb_id IN (?)")
        conditions.push(params[:fb_id])
      end
    end
    if params[:restaurant_id]
      if params[:restaurant_id].blank?
        str_arr.push("restaurant_id IS NULL")
      elsif params[:restaurant_id].class == String
        str_arr.push("restaurant_id = ?")
        conditions.push(params[:restaurant_id])
      elsif params[:restaurant_id].class == Array
        str_arr.push("restaurant_id IN (?)")
        conditions.push(params[:restaurant_id])
      end
    end
    if params[:restaurant_location]
      if params[:restaurant_location].blank?
        str_arr.push("restaurant_location IS NULL")
      elsif params[:restaurant_location].class == String
        str_arr.push("restaurant_location = ?")
        conditions.push(params[:restaurant_location])
      elsif params[:restaurant_location].class == Array
        str_arr.push("restaurant_location IN (?)")
        conditions.push(params[:restaurant_location])
      end
    end
    conditions.prepend(str_arr.join(" AND "))

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
    unless sort_property == "id"
      order += ", id ASC"
    end

    # Custom limit?
    limit = params[:limit] ? params[:limit].to_i : User.count

    # Special parameters?
    if params[:near_user]
      user = User.find_by_id(params[:near_user])
      users = []

      # lower scores than the user
      str = "id <> ? AND score <= ? AND restaurant_id = ? AND "
      str += user[:restaurant_location].nil? ?
             "restaurant_location IS NULL" :
             "restaurant_location = ?"
      conditions = [str, user[:id], user[:score], user[:restaurant_id]]
      unless user[:restaurant_location].nil?
        conditions.push(user[:restaurant_location])
      end
      users += User.where(conditions).order("score DESC, id ASC").limit(6)

      # user himself
      users.push(user)

      # higher scores than the user
      str = "id <> ? AND score > ? AND restaurant_id = ? AND "
      str += user[:restaurant_location].nil? ?
             "restaurant_location IS NULL" :
             "restaurant_location = ?"
      conditions = [str, user[:id], user[:score], user[:restaurant_id]]
      unless user[:restaurant_location].nil?
        conditions.push(user[:restaurant_location])
      end
      users += User.where(conditions).order("score ASC, id ASC").limit(9)

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
    return false if Constants::PHASE == "tournament"

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
    user[:restaurant_location] = params[:user][:restaurant_location]
    user[:contact_allowed] = params[:user][:contact_allowed]
    user.save
    user.extend_access_token

    render :json => user
  end

  # PUT /users/:id
  def update
    user = User.find_by_id(params[:id])
    og_access_token = user[:fb_access_token]
    user[:fb_id] = params[:user][:fb_id].blank? ?
                   nil : params[:user][:fb_id]
    user[:fb_username] = params[:user][:fb_username].blank? ?
                         nil : params[:user][:fb_username]
    user[:fb_access_token] = params[:user][:fb_access_token].blank? ?
                             nil : params[:user][:fb_access_token]
    user[:name] = params[:user][:name].blank? ?
                  nil : params[:user][:name]
    user[:email] = params[:user][:email].blank? ?
                   nil : params[:user][:email]
    user[:gender] = params[:user][:gender].blank? ?
                    nil : params[:user][:gender]
    user[:timezone] = params[:user][:timezone].blank? ?
                      nil : params[:user][:timezone]
    user[:phone] = params[:user][:phone].blank? ?
                   nil : params[:user][:phone]
    user[:restaurant_id] = params[:user][:restaurant_id].blank? ?
                           nil : params[:user][:restaurant_id]
    user[:restaurant_location] = params[:user][:restaurant_location].blank? ?
                                 nil : params[:user][:restaurant_location]
    user[:contact_allowed] = params[:user][:contact_allowed].blank? ?
                             nil : params[:user][:contact_allowed]
    user.save

    unless user.fb_access_token == og_access_token
      user.extend_access_token
    end

    render :json => user
  end
end
