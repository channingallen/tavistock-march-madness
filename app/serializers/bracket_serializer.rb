class BracketSerializer < ActiveModel::Serializer
  attributes :id,
             :is_official

  has_one :user, :embed => :ids
  has_many :games, :embed => :ids, :include => true
end