class LessonSerializer < ActiveModel::Serializer
  attributes :id, :minutes, :rated, :confirmed, :paid, :finished, :meetingtime, :conversation_id, :project_id,
             :seconds, :name, :token,  :start, :end, :teacher_id, :student_id, :pronunciation_rate, :knowledge_rate,
             :explanation_rate, :positive_comment, :negative_comment, :paymentrequestapproved, :paymentrequestdenied,
             :created_at


  def minutes
    if object.seconds
      object.seconds / 60
    end
  end
end
