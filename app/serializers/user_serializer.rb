class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :score,
             :phone,
             :contact_allowed,
             :gender,
             :timezone,
             :rank,
             :fb_username,
             :fb_id,
             :restaurant_id

  def rank
    str = "(score < ? OR (score = ? AND created_at < ?)) AND restaurant_id "
    str += object[:restaurant_id] ? "= ?" : "IS NULL"
    conds = [str,
             object[:score],
             object[:score],
             object[:created_at]]
    conds.push(object[:restaurant_id]) if object[:restaurant_id]
    User.count(:conditions => conds) + 1
  end

  has_one :bracket, :embed => :ids, :key => :bracket_id
end