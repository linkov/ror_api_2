require 'descriptive_statistics'

class ChoosethebestProjectSerializer < ActiveModel::Serializer
  attributes :choosethebest, :category_name, :id, :user_id
  has_many :projectfiles, serializer: ProjectfileSerializer

  def category_name
    object.artcategory.name
  end
end
