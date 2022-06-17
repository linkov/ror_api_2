class ConversationUserskillSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :user_skill_id, :skill, :rate

  def skill
    UserSkill.find(object.user_skill_id).skill
  end

  def rate
    UserSkill.find(object.user_skill_id).rate
  end

end
