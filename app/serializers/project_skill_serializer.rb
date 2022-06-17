class ProjectSkillSerializer < ActiveModel::Serializer
  attributes :id, :project_id, :icon, :skill_id, :skill

  def icon
    Skill.find(object.skill_id).icon
  end

  def skill
    Skill.find(object.skill_id)
  end


end
