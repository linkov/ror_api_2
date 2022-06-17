class ParentcategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :artfield_id, :categories, :display_name

  def categories
    object.categories.collect(&:id)
  end

  def display_name
    artfield = Artfield.find(object.artfield_id)
    artfield.name + ' ➝ ' + object.name
  end
end
