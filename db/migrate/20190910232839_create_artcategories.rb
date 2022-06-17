class CreateArtcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :artcategories do |t|
      t.string :name
      t.references :parent
      t.timestamps
    end
  end
end
