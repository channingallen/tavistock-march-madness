class PagesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:index]

  def index

    # Ensure the visitor has come to the app via Facebook.
    if Rails.env.production?
      data = parse_signed_request
    elsif params["no_user"]
      data = {}
    else
      data = {
        "user_id" => Constants::TEST_USER_FB_ID,
        "oauth_token" => "1234567890"
      }
    end

    # If the visitor has authenticated our app, retrieve his account (or create
    # one if he doesn't already have one) and pass its data to the view.
    if data["user_id"] and data["oauth_token"]
      user = User.find_by_fb_id(data["user_id"])
      unless user
        user = User.new
        user[:fb_id] = data["user_id"]
        user[:fb_access_token] = data["oauth_token"]
        user[:name] = nil
        user[:email] = nil
        user[:gender] = nil
        user[:timezone] = nil
        user[:fb_username] = nil
        user.save!
      end
      bracket = user.bracket
      games = bracket.games
      teams = Team.all
      @user_data = {
        :user => UserSerializer.new(user).as_json[:user],
        :bracket => BracketSerializer.new(bracket).as_json[:bracket],
        :games => ActiveModel::ArraySerializer.new(games).as_json,
        :teams => ActiveModel::ArraySerializer.new(teams).as_json
      }.to_json

    # Otherwise, we pass nil so the view will know that the user hasn't
    # authenticated.
    else
      @user_data = nil
    end

  rescue Exception => e
    logger.info "#{e.class} - #{e.message}"

    redirect_error_messages = [
      "Must be POST request.",
      "Unknown algorithm. Expected HMAC-SHA256.",
      "Bad signed JSON signature.",
    ]
    if redirect_error_messages.include?(e.message) and Rails.env.production?
      redirect_to Constants::FB_APP_URL
    end
  end

  def page_tab

    # Verify the signed request and gather data.
    if Rails.env.production?
      data = parse_signed_request
      @liked = data["page"]["liked"]
      @page_id = data["page"]["id"]
    else
      @liked = params["liked"]
      @page_id = params["page_id"]
    end

    render :layout => "page_tab"

  rescue Exception => e
    render :text => "Unsupported page."
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

end
