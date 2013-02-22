class User < ActiveRecord::Base

  attr_accessible :name, :email, :fb_id, :gender, :timezone, :fb_username,
                  :fb_access_token, :phone, :restaurant_id, :contact_allowed,
                  :restaurant_location


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

  # TODO: put methods here


end