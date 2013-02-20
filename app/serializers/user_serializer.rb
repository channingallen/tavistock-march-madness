class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :score,
             :gender,
             :timezone,
             :fb_username,
             :fb_id

  has_one :bracket, :embed => :ids, :key => :bracket_id
end