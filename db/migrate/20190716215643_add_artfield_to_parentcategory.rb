class AddArtfieldToParentcategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :parentcategories, :artfield, foreign_key: true
  end
end
