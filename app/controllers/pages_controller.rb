require 'net/http'
require 'net/https'

class PagesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:index]

  def index

    # Verify the signed request, and gather basic data.
    if Rails.env.production?
      data = parse_signed_request
      logger.info "data: #{data.inspect}"

      user = User.find_by_fb_id(data["user_id"])

      # If there's no page (because the user access the canvas app directly) or
      # if the user has already signed up for a different page, redirect.
     if !data["page"] or (user and user.restaurant_id and user.restaurant_id != data["page"]["id"])
        page_id = "486859618037849"
        if user and !user.restaurant_id.blank?
          page_id = user.restaurant_id
        end
        @page_url = find_page_app_url(page_id)
        render :layout => "redirect_to_page", :template => "pages/redirect_to_page"
        return
      else
        liked = data["page"]["liked"]
        @page_id = data["page"]["id"]
      end
    else
      data = params["no_user"] ?
             {} :
             { "user_id" => Constants::TEST_USER_FB_ID,
               "oauth_token" => "1234567890" }
      liked = !!params["liked"]
      @page_id = params["page_id"]
    end

    unless @page_id
      raise "Must specify a page ID."
    end

    unless liked
      render :layout => "like_gate", :template => "pages/like_gate"
      return
    end

    # If the visitor has authenticated our app, retrieve his account (or create
    # one if he doesn't already have one) and pass its data to the view.
    if data["user_id"] and data["oauth_token"]

      # Update/create the user.
      user = User.find_by_fb_id(data["user_id"])
      unless user
        user = User.new
        user[:fb_id] = data["user_id"]
      end
      user[:fb_access_token] = data["oauth_token"]
      user[:restaurant_id] = @page_id
      extend_access_token = user.new_record?
      user.save!
      if extend_access_token and Rails.env.production?
        user.extend_access_token
      end

      # Build data.
      bracket = user.bracket
      games = bracket.games
      teams = Team.all
      @initial_data = {
        :user => UserSerializer.new(user).as_json[:user],
        :bracket => BracketSerializer.new(bracket).as_json[:bracket],
        :games => ActiveModel::ArraySerializer.new(games).as_json,
        :teams => ActiveModel::ArraySerializer.new(teams).as_json
      }.to_json
    else
      teams = Team.all
      @initial_data = {
        :teams => ActiveModel::ArraySerializer.new(teams).as_json
      }.to_json
    end

  rescue Exception => e
    logger.info "#{e.class} - #{e.message}"
    render :text => "An error occurred.<br/>#{e.class} - #{e.message}"
  end

  # Called by Facebook for their Javascript SDK. More information here:
  # http://developers.facebook.com/docs/reference/javascript/
  def channel
    expires_in 1.year, :public => true
    one_year = Time.now.advance(:years => 1)
    response.headers["Expires"] = one_year.strftime("%a, %d %b %Y %H:%M:%S GMT")
    response.headers["Pragma"] = "public"

    text = "<script src=\"//connect.facebook.net/en_US/all.js\"></script>"
    render :text => text
  end

  def rankings
    @ranking_data = []

    Constants::RESTAURANTS.each_pair do |rest_id, rest_data|
      if rest_data[:locations]
        rest_data[:locations].each do |rest_location|
          this_ranking_data = { :name => "#{rest_data[:name]} (#{rest_location})" }
          rest_users = User.
            where(:restaurant_id => rest_id, :restaurant_location => rest_location)
          users = rest_users.
            where("score > 0").
            where("contact_allowed = FALSE or email IS NOT NULL").
            order('score DESC, id ASC').
            limit(25)
          this_ranking_data[:users] = users.collect do |user|
            {
              :id => user.id,
              :name => user.name,
              :score => user.score,
              :email => user.contact_allowed ? user.email : "#{user.email}, no contact allowed",
              :phone => user.phone
            }
          end

          this_ranking_data[:num_total_signups] = rest_users.size
          this_ranking_data[:num_filled_out_form] = rest_users.
            where("email IS NOT NULL").
            size
          this_ranking_data[:num_started_bracket] = 0
          this_ranking_data[:num_finished_bracket] = 0
          rest_users.each do |u|
            num_chosen_games = u.games.where("winning_team_id IS NOT NULL").size
            if num_chosen_games == 67
              this_ranking_data[:num_finished_bracket] += 1
            elsif num_chosen_games > 0
              this_ranking_data[:num_started_bracket] += 1
            end
          end

          @ranking_data.push(this_ranking_data)
        end

      else
        this_ranking_data = { :name => rest_data[:name] }
        rest_users = User.where(:restaurant_id => rest_id)
        users = rest_users.
          where("score > 0").
          where("contact_allowed = FALSE or email IS NOT NULL").
          order('score DESC, id ASC').
          limit(25)
        this_ranking_data[:users] = users.collect do |user|
          {
            :id => user.id,
            :name => user.name,
            :score => user.score,
            :email => user.contact_allowed ? user.email : "#{user.email}, no contact allowed",
            :phone => user.phone
          }
        end

        this_ranking_data[:num_total_signups] = rest_users.size
        this_ranking_data[:num_filled_out_form] = rest_users.
          where("email IS NOT NULL").
          size
        this_ranking_data[:num_started_bracket] = 0
        this_ranking_data[:num_finished_bracket] = 0
        rest_users.each do |u|
          num_chosen_games = u.games.where("winning_team_id IS NOT NULL").size
          if num_chosen_games == 67
            this_ranking_data[:num_finished_bracket] += 1
          elsif num_chosen_games > 0
            this_ranking_data[:num_started_bracket] += 1
          end
        end

        @ranking_data.push(this_ranking_data)
      end
    end

    render :layout => "blank"
  end

  private

  # Raises an error if the request wasn't made via the Facebook app canvas (i.e.
  # a POST request with a valid "signed_request" parameter).
  #
  # Returns parameter data parsed from the "signed_request" parameter.
  def parse_signed_request
    raise "Must be POST request." unless request.post?

    signed_request = params["signed_request"]
    encoded_sig, payload = signed_request.split('.')

    data = ActiveSupport::JSON.decode(base64_url_decode(payload))
    verify_signed_request(data, encoded_sig, payload)

    data
  end

  # Helper method for parsing Facebook's "signed_request" parameter.
  def verify_signed_request(data, encoded_sig, payload)
    unless data["algorithm"].upcase == "HMAC-SHA256"
      raise "Unknown algorithm. Expected HMAC-SHA256."
    end

    secret = Constants::FB_APP_SECRET
    actual_signature = base64_url_decode(encoded_sig)
    expected_signature = Digest::HMAC.digest(payload, secret, Digest::SHA256)
    unless actual_signature == expected_signature
      logger.info "expected_sig: #{expected_signature}"
      logger.info "         sig: #{actual_signature}"
      logger.info "        data: #{data.inspect}"
      raise "Bad signed JSON signature."
    end
  end

  # Helper method for parsing Facebook's "signed_request" parameter.
  def base64_url_decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end

  def find_page_app_url(page_id)
    url = "http://graph.facebook.com/#{page_id}"
    uri = URI.parse(URI.encode(url))
    request = Net::HTTP::Get.new(uri.path)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(request)
    raise "error" unless response.code == "200"

    json = JSON.parse(response.body)
    "#{json["link"]}/app_#{Constants::FB_APP_ID}"

  rescue Exception => e
    logger.info "\n\n#{e.class} - #{e.message}\n\n"
    "http://www.facebook.com"
  end

end
