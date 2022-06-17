class AddParentcategoryToCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :parentcategory, foreign_key: true
  end
end
