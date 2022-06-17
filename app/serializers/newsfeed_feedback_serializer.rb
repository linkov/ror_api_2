class NewsfeedFeedbackSerializer < ActiveModel::Serializer
  attributes :id, :profileimage, :isprofeedback, :wasPaid, :text, :project_id, :order, :project_sharetoken,
             :newsfeed_question_type,  :avratingparam, :avratingparam_id, :avtracktimeposition, :in_open_card_session,
             :feedbacktype, :link, :created_at, :display_type, :rating_id, :drawing, :score, :rateback_score,
             :project_category, :projectfile_id, :artist_id, :commenter_id

  def newsfeed_question_type
    'feedback'
  end

  def profileimage
    object.rating.user.image
  end

  def isprofeedback
    if object.rating.feedbacksession
      return true
    end

    return false
  end

  def wasPaid
    session = object.rating.feedbacksession
    if session && session.paid == true
      return true
    end
    return false
  end



  def in_open_card_session
    object.ratebacks.count.zero? ? true : false
  end

  def project_sharetoken
    object.rating.project.sharetoken
  end

  def project_id
    object.rating.project_id
  end

  def artist_id
    project = object.rating.project
    artist_id = project.user_id
  end

  def commenter_id
    object.rating.user_id
  end

  def link
    if object.link
      if !url_protocol_present(object.link)
        "http://#{object.link}"
      else
        object.link
      end
    end
  end

  def score
     object.rating.slidervalue
  end

  def projectfile_id
    object.rating.projectfile_id
  end

  def project_category
    object.rating.project.artcategory.name
  end

  def rateback_score
    ratebacks = object.ratebacks
    if ratebacks.count > 0
      ratebacks.first.value
    else
      -1
    end
  end

  def display_type
    rating = object.rating
    if rating.ratingtype == 'files'
      'file'
    elsif rating.ratingtype == 'project'
    'project'
  else
    'concept'
  end

  end

  def url_protocol_present(link)
    link[/\Ahttp:\/\//] || link[/\Ahttps:\/\//]
  end

end
