class ArtcategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :parent_id, :order, :bound_to_skill, :is_active
  has_many :subcategories
end
