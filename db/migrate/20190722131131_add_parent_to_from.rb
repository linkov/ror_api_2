class AddParentToFrom < ActiveRecord::Migration[5.2]
  def change
    add_reference :categoryrelations, :fromparentcategory
    add_reference :categoryrelations, :toparentcategory
  end
end
