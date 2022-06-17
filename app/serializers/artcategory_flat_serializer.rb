class ArtcategoryFlatSerializer < ActiveModel::Serializer
  attributes :id, :name, :order, :bound_to_skill, :is_active
end
