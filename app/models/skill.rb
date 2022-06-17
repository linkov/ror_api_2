class Skill < ApplicationRecord
  has_many :artcategory_skills, -> { order(order: :asc) }
  has_many :user_skills

  accepts_nested_attributes_for :artcategory_skills,
                                allow_destroy: true,
                                reject_if: :all_blank

  # def artcategories
  #   artcategory_skills.map { |as| {id: as.artcategory.id, artcategory_skill_id: as.id, name: as.artcategory.name, order: as.order } }
  # end
end
