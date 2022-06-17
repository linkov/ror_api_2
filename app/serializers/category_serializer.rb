class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :parentcategory_id, :display_name


  def display_name
    parent = Parentcategory.find(object.parentcategory_id)
    parent.name + ' ➝ ' + object.name
  end
end
