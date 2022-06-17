class ArtrelationSerializer < ActiveModel::Serializer
  attributes :id, :fromcategory_id, :tocategory_id, :weight
end
