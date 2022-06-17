class PresenterquestionanswerStatsSerializer < ActiveModel::Serializer
  attributes :id, :answer, :presenterquestion_id, :user_id, :project_id
  belongs_to :presenterquestion

  def project_id
    question = Presenterquestion.find(object.presenterquestion_id)
    project = Project.find(question.project_id)
    project.id
  end

end
