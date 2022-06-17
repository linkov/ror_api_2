class AddParentcategoryToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :parentcategory, foreign_key: true
  end
end
