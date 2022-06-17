class CategoryrelationSerializer < ActiveModel::Serializer
  attributes :id, :fromcategory_id, :tocategory_id, :fromparentcategory_id, :toparentcategory_id, :weight

end
