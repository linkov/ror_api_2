class SkillSerializer < ActiveModel::Serializer
  attributes :id, :shortname, :name, :icon, :link, :advisors_count, :artcategory_skills

  def advisors_count
    object.user_skills.count
  end

  def artcategory_skills
    object.artcategory_skills.map { |as| {id: as.id, artcategory_id: as.artcategory_id, name: as.artcategory.name, order: as.order } }
  end
end
