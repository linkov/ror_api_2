require 'descriptive_statistics'

class PresenterquestionProjectSerializer < ActiveModel::Serializer
  attributes :presenterquestion, :category_name, :id
  has_many :projectfiles, serializer: ProjectfileSerializer


  def category_name
    Artcategory.find(object.artcategory_id).name unless object.artcategory_id.nil?
  end


end
