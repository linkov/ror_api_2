class AdminCategoryrelationSerializer < ActiveModel::Serializer
  attributes :id, :fromcategory_id, :tocategory_id, :weight, :tocategory_name, :fromcategory_name, :discouraging, :unhelpful, :notsure, :helpful, :inspiring


  def tocategory_name
    category = Artcategory.find(object.tocategory_id)
    return category.name
  end

  def fromcategory_name
    category = Artcategory.find(object.fromcategory_id)
    return category.name
  end


  def discouraging
    ratings = Rating.where(:categoryrelation_id => object.id)
    ratebacks = Rateback.where(:feedback_id => Feedback.where(:rating_id => ratings.collect(&:id)) , :value => 1).count
  end

  def unhelpful
    ratings = Rating.where(:categoryrelation_id => object.id)
    ratebacks = Rateback.where(:feedback_id => Feedback.where(:rating_id => ratings.collect(&:id)), :value => 2).count
  end

  def notsure
    ratings = Rating.where(:categoryrelation_id => object.id)
    ratebacks = Rateback.where(:feedback_id => Feedback.where(:rating_id => ratings.collect(&:id)), :value => 3).count
  end

  def helpful
    ratings = Rating.where(:categoryrelation_id => object.id)
    ratebacks = Rateback.where(:feedback_id => Feedback.where(:rating_id => ratings.collect(&:id)), :value => 4).count
  end

  def inspiring
    ratings = Rating.where(:categoryrelation_id => object.id)
    ratebacks = Rateback.where(:feedback_id => Feedback.where(:rating_id => ratings.collect(&:id)), :value => 5).count
  end

end
