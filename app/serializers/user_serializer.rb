class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :score

  has_one :bracket, :embed => :ids, :key => :bracket_id
end