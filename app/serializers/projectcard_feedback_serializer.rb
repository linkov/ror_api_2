class ProjectcardFeedbackSerializer < ActiveModel::Serializer
  attributes :id, :text, :project_id, :order, :avratingparam, :avratingparam_id, :avtracktimeposition, :in_open_card_session, :feedbacktype, :link, :created_at, :display_type, :rating_id, :drawing, :score, :rateback_score, :project_category, :projectfile_id, :artist_id, :commenter_id

  def in_open_card_session
    ratebacks_count = Rateback.where(:feedback_id => object.id).count
    if ratebacks_count == 0
      return true
    else
      return false
    end

  end

  def avratingparam
    if object.avratingparam_id
      Avratingparam.find(object.avratingparam_id)
    end
  end

  def project_id
    rating = Rating.find(object.rating_id)
    project = Project.find(rating.project_id)
    project.id
  end

  def artist_id
    rating = Rating.find(object.rating_id)
    project = Project.find(rating.project_id)
    artist_id = project.user_id
  end

  def commenter_id
    rating = Rating.find(object.rating_id)
    rating.user_id
  end

  def link
    if object.link && !url_protocol_present(object.link)
      "http://#{object.link}"
    end
  end

  def score
     rating = Rating.find(object.rating_id)
     rating.slidervalue

  end

  def projectfile_id
    rating = Rating.find(object.rating_id)
    rating.projectfile_id

  end

  def project_category
    rating = Rating.find(object.rating_id)
    project = Project.find(rating.project_id)
    category = Artcategory.find(project.artcategory_id)
    category.name
  end

  def rateback_score
    ratebacks = Rateback.where(:feedback_id => object.id)
    if ratebacks.count > 0
      ratebacks.first.value
    else
      -1
    end


  end


  def display_type
    rating = Rating.find(object.rating_id)
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
