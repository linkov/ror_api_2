class InviteSerializer < ActiveModel::Serializer
  attributes :id, :email, :message, :name
  has_one :project
end
