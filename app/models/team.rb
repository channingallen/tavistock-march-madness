class Team < ActiveRecord::Base

  attr_accessible :name, :rank


  ###################
  #   Validations   #
  ###################

  validates :name, :presence => true
  validates :name, :length => { :maximum => 200, :minimum => 1 }
  validates :name, :uniqueness => true
  validates :rank, :presence => true


  #################
  #   Callbacks   #
  #################

  # TODO: put callbacks here


  ###############
  #   Methods   #
  ###############

  # TODO: put methods here

end
