class ArtfieldSerializer < ActiveModel::Serializer
  attributes :id, :name, :tag, :parentcategories

def parentcategories
  object.parentcategories.collect(&:id)
end
end
