require 'descriptive_statistics'

class UserSkillSerializer < ActiveModel::Serializer
  attributes :id, :level, :order, :rate, :user_id, :overall_skill_score, :knowledge_skill_score, :explanation_skill_score,
             :articulation_skill_score, :hours_skill_score, :reviews

  has_one :skill

  def overall_skill_score
    0
  end

  def knowledge_skill_score

    skills = ConversationUserskill.where(:user_skill_id => object.id)
    lessons = Lesson.where(:teacher_id => object.user_id, :conversation_id => skills.collect(&:conversation_id))

    if lessons.count > 0
      lessons.collect(&:knowledge_rate).mean.ceil.to_i  / 10
    else
      0
    end

  end

  def explanation_skill_score
    skills = ConversationUserskill.where(:user_skill_id => object.id)
    lessons = Lesson.where(:teacher_id => object.user_id, :conversation_id => skills.collect(&:conversation_id))

    if lessons.count > 0
      lessons.collect(&:explanation_rate).mean.ceil.to_i / 10
    else
      0
    end
  end

  def articulation_skill_score

    skills = ConversationUserskill.where(:user_skill_id => object.id)
    lessons = Lesson.where(:teacher_id => object.user_id, :conversation_id => skills.collect(&:conversation_id))

    if lessons.count > 0
      lessons.collect(&:pronunciation_rate).mean.ceil.to_i  / 10
    else
      0
    end
  end

  def hours_skill_score
    skills = ConversationUserskill.where(:user_skill_id => object.id)
    lessons = Lesson.where(:teacher_id => object.user_id, :conversation_id => skills.collect(&:conversation_id))

    lessons.count > 0 ? lessons.sum(&:seconds) : 0
  end

  def reviews
    object.conversations.map do |conversation|
      conversation.lessons.map { |lesson| lesson.attributes.slice('student_id', 'positive_comment', 'negative_comment') }
    end.flatten
  end
end
