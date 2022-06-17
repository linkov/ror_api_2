class AddFieldOrderToArtcategories < ActiveRecord::Migration[5.2]
  def change
    add_column :artcategories, :order, :integer
    add_column :artcategories, :bound_to_skill, :boolean, default: false
    add_column :artcategories, :is_active, :boolean, default: false
  end
end
