class AddArtcategoryToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :artcategory, foreign_key: true
  end
end
