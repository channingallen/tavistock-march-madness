class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :score,
             :gender,
             :timezone,
             :rank,
             :fb_username,
             :fb_id

  def rank
    conds = ["score < ? OR (score = ? AND created_at < ?)",
             object[:score],
             object[:score],
             object[:created_at]]
    User.count(:conditions => conds) + 1
  end

  has_one :bracket, :embed => :ids, :key => :bracket_id
end