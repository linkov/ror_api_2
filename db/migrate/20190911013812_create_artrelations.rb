class CreateArtrelations < ActiveRecord::Migration[5.2]
  def change
    create_table :artrelations do |t|
      t.integer :fromcategory_id
      t.integer :tocategory_id
      t.float :weight

      t.timestamps
    end
  end
end
