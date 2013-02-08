class User < ActiveRecord::Base

  ####################
  #   Associations   #
  ####################

  has_one :bracket


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

  # TODO: put callbacks here
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