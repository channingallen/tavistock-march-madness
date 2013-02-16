class PagesController < ApplicationController

  def index
    data = parse_signed_request(params["signed_request"])
    render :text => data

    user = User.first
    bracket = user.bracket
    games = bracket.games
    teams = Team.all

    @json_data = {
      :user => UserSerializer.new(user).as_json[:user],
      :bracket => BracketSerializer.new(bracket).as_json[:bracket],
      :games => ActiveModel::ArraySerializer.new(games).as_json,
      :teams => ActiveModel::ArraySerializer.new(teams).as_json
    }.to_json
  rescue Exception => e
    render :text => "#{e.class} - #{e.message}"
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

  # "uhzpEBgxkChn0b-hPU5hMLVF_Zq6yOVgMin4g4PeN28.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImlzc3VlZF9hdCI6MTM2MTAxMDQ0OCwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX19"
  # {"algorithm"=>"HMAC-SHA256", "issued_at"=>1361010448, "user"=>{"country"=>"us", "locale"=>"en_US", "age"=>{"min"=>21}}}
  def parse_signed_request(signed_request)
    encoded_sig, payload = signed_request.split('.')

    # Decode the data.
    data = ActiveSupport::JSON.decode(base64_url_decode(payload))

    # Ensure the expected algorithm was used.
    unless data["algorithm"].upcase == "HMAC-SHA256"
      raise "Unknown algorithm. Expected HMAC-SHA256."
    end

    # Verify the request.
    sig = base64_url_decode(encoded_sig)
    expected_sig = Digest::HMAC.hexdigest(payload, Constants::FB_APP_SECRET,
                                          Digest::SHA1)
    raise "Bad signed JSON signature." unless sig == expected_sig

    data
  end

  def base64_url_decode(str)
    # Method 1:
    #str = str.gsub('-','+').gsub('_','/')
    #str += '=' while !(str.size % 4).zero?
    #Base64.decode64(str)

    # Method 2:
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end

end