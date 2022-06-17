class ProjectresortSerializer < ActiveModel::Serializer
  attributes :id, :comment
  has_one :user
  has_one :project
  has_many :resortimages
end
