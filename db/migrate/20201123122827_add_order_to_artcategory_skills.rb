class AddOrderToArtcategorySkills < ActiveRecord::Migration[5.2]
  def change
    add_column :artcategory_skills, :order, :integer, default: 0
  end
end
