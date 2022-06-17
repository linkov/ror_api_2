require 'descriptive_statistics'

class GetpaidProjectSerializer < ActiveModel::Serializer
  attributes :user_id, :created_at, :category_name, :inspiringrate, :choosethebest, :sharetoken, :presenterquestion,
             :id, :title, :description, :purpose, :category_id, :parentcategory_id, :review_count, :new_review_count,
             :category_name, :total_score, :project_score, :relation_id, :artcategory_id

  has_many :projectfiles, serializer: ProjectfileSerializer
  belongs_to :user
  has_many :avratingparams

  def relation_id
    if scope[:relation]
      puts "RELATION HERE>>"
      puts scope[:relation].id
      scope[:relation].id
    end


  end

  def total_score
     if object.ratings.count > 0
       score = object.ratings.collect(&:slidervalue).mean.ceil.to_i
     else
       return 50
     end

  end

  def project_score
    all_ratings = object.ratings.where(:ratingtype => 'project')
    if all_ratings.length > 0
      score = all_ratings.collect(&:slidervalue).mean.ceil.to_i
    else
      return 50
    end
  end

  def review_count
    object.ratings.count
  end

  def category_name
    object.artcategory.name unless object.artcategory_id.nil?
  end

  def new_review_count
    feedbacks = Feedback.where(:rating_id => object.ratings.collect(&:id))
    project_feedbacks_count = feedbacks.count
    project_ratebacks_count = Rateback.where(:feedback_id => feedbacks.collect(&:id)).count

    return project_feedbacks_count - project_ratebacks_count
  end

end
