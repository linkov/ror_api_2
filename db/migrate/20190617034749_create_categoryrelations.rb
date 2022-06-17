class CreateCategoryrelations < ActiveRecord::Migration[5.2]
  def change
    create_table :categoryrelations do |t|
      t.float :weight
      t.references :fromcategory
      t.references :tocategory

      t.timestamps
    end
  end
end
