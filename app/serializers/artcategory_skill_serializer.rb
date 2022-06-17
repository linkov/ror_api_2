class ArtcategorySkillSerializer < ActiveModel::Serializer
  attributes :artcategory_skill_id

  def artcategory_skill_id
    object.id
  end
end
