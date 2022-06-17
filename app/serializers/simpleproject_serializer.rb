class SimpleprojectSerializer < ActiveModel::Serializer
  attributes :id, :title, :category_name, :user_id, :isprivate, :private

  def category_name
    Artcategory.find(object.artcategory_id).name unless object.artcategory_id.nil?
  end
  def isprivate
    object.private
  end

end
