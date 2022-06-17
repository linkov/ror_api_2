class AddparentartcategoryIdToSkip < ActiveRecord::Migration[5.2]
  def change
    add_column :skips, :parentartcategory_id, :integer
  end
end
