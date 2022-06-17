require 'descriptive_statistics'

class AdminProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :purpose, :category_id, :parentcategory_id, :review_count, :new_review_count, :category_name, :total_score, :project_score, :created_at, :last_rate_time, :artcategory_id
  has_many :projectfiles, serializer: ProjectfileSerializer
  belongs_to :user

  def total_score
     all_ratings = Rating.where(:project_id => object.id)
     if all_ratings.length > 0
       score = all_ratings.collect(&:slidervalue).mean.ceil.to_i
     else
       return 50
     end

  end

  def last_rate_time
    last_rate = object.ratings.order(:created_at).reverse().first
    if last_rate
      last_rate.created_at
    end

  end

  def project_score
    all_ratings = Rating.where(:project_id => object.id, :ratingtype => 'project')
    if all_ratings.length > 0
      score = all_ratings.collect(&:slidervalue).mean.ceil.to_i
    else
      return 50
    end
  end

  def review_count
    object.ratings.select("DISTINCT user_id").count
  end

  def category_name
    Artcategory.find(object.artcategory_id).name unless object.artcategory_id.nil?
  end

  def new_review_count
    feedbacks = Feedback.where(:rating_id => object.ratings.collect(&:id))
    project_feedbacks_count = feedbacks.count
    project_ratebacks_count = Rateback.where(:feedback_id => feedbacks.collect(&:id)).count

    return project_feedbacks_count - project_ratebacks_count


  end

end
