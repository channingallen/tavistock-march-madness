class User < ActiveRecord::Base

  attr_accessible :name, :email, :score


  ####################
  #   Associations   #
  ####################

  has_one :bracket, :dependent => :destroy


  ###################
  #   Validations   #
  ###################

  validates :name, :presence => true
  validates :name, :length => { :maximum => 200, :minimum => 1 }
  validates :email, :length => { :maximum => 200, :minimum => 1 }, :allow_nil => true
  validates :score, :length => { :minimum => 0 }


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