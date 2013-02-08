class Team < ActiveRecord::Base

  ###################
  #   Validations   #
  ###################

  validates :name, :presence => true
  validates :name, :length => { :maximum => 200, :minimum => 1 }


  #################
  #   Callbacks   #
  #################

  # TODO: put callbacks here


  ###############
  #   Methods   #
  ###############

  # TODO: put methods here

end
