class AddArtcategoryToSkip < ActiveRecord::Migration[5.2]
  def change
    add_reference :skips, :artcategory, foreign_key: true
  end
end
