class BracketSerializer < ActiveModel::Serializer
  attributes :id,
             :is_official,
             :user_id

  has_many :games, :embed => :ids
end