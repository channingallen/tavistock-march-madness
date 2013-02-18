class TeamSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :rank
end
