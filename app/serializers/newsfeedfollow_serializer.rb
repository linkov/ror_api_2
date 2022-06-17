class NewsfeedfollowSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :artist_id, :commenter_id, :project_id
end
