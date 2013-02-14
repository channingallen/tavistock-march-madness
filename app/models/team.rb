class Team < ActiveRecord::Base

  attr_accessible :name


  ###################
  #   Validations   #
  ###################

  validates :name, :presence => true
  validates :name, :length => { :maximum => 200, :minimum => 1 }
  validates :name, :uniqueness => true


  #################
  #   Callbacks   #
  #################

  # TODO: put callbacks here


  ###############
  #   Methods   #
  ###############

  # TODO: put methods here

end
