require 'net/http'
require 'net/https'

class User < ActiveRecord::Base

  attr_accessible :name, :email, :fb_id, :gender, :timezone, :fb_username,
                  :fb_access_token, :phone, :restaurant_id, :contact_allowed,
                  :restaurant_location, :score


  ####################
  #   Associations   #
  ####################

  has_one :bracket, :dependent => :destroy
  has_many :games, :through => :bracket


  ###################
  #   Validations   #
  ###################

  validates :email, :uniqueness => true, :allow_nil => true
  validates :score, :numericality => { :greater_than_or_equal_to => 0 }
  validates :fb_id, :uniqueness => true, :allow_nil => true
  validates :fb_username, :uniqueness => true, :allow_nil => true
  validates :fb_access_token, :uniqueness => true, :allow_nil => true
  validates :name, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :phone, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :email, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :fb_id, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :gender, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :timezone, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :fb_username, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :restaurant_id, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :fb_access_token, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true
  validates :restaurant_location, :length => { :maximum => Constants::MAX_DB_STRING_LENGTH, :minimum => 1 }, :allow_nil => true

  #################
  #   Callbacks   #
  #################

  after_create :build_bracket

  def build_bracket
    bracket = Bracket.new
    bracket.user_id = self[:id]
    bracket.save
  end


  ###############
  #   Methods   #
  ###############

  def extend_access_token
    params = {
      :grant_type => "fb_exchange_token",
      :client_id => Constants::FB_APP_ID,
      :client_secret => Constants::FB_APP_SECRET,
      :fb_exchange_token => self.fb_access_token
    }
    url = "https://graph.facebook.com/oauth/access_token"
    uri = URI.parse(URI.encode(url))
    path_with_params = uri.path + "?" + CGI.unescape(params.to_query)

    request = Net::HTTP::Get.new(path_with_params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(request)

    if response.code == "200"
      response.body.split("&").each do |part|
        index = part.index("access_token=")
        if index
          new_token = part[("access_token=".length + index)..part.length]
          self.fb_access_token = new_token
          self.save!
          return
        end
      end
      raise "no access token found in response body: #{response.body}"
    else
      raise "#{response.code} - #{response.body}"
    end
  end


end