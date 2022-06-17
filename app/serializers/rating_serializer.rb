class RatingSerializer < ActiveModel::Serializer
  attributes :id, :slidervalue, :ratingtype, :file_id, :filehandle, :user_id, :created_at, :open_card_session, :feedbacksession_id
  has_many :feedbacks


  # def open_card_session
  #   ratebacks_count = Rateback.where(:feedback_id => object.id).count
  #   if ratebacks_count == 0
  #     return true
  #   else
  #     return false
  #   end
  #
  # end

  def open_card_session
    feedbacks_count = object.feedbacks.count
    ratebacks_count = Rateback.where(:feedback_id => object.feedbacks.collect(&:id)).count

    return ratebacks_count != feedbacks_count
  end

  def file_id
    object.projectfile_id
  end

  def filehandle
    if object.ratingtype == "files"
      file = Projectfile.find(object.projectfile_id)
      return file.handle
    end

  end

end
