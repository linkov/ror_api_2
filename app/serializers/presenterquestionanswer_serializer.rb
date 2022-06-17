class PresenterquestionanswerSerializer < ActiveModel::Serializer
  attributes :id, :answer, :presenterquestion_id, :user_id
end
