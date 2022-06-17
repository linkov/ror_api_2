class CreateArtfields < ActiveRecord::Migration[5.2]
  def change
    create_table :artfields do |t|
      t.string :name
      t.string :tag

      t.timestamps
    end
  end
end
