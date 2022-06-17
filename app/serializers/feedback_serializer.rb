class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :text, :order, :feedbacktype, :link, :created_at, :display_type, :rating_id, :drawing

  def link
    if object.link && !url_protocol_present(object.link)
      "http://#{object.link}"
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
