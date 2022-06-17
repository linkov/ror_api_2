class CreateArttagfields < ActiveRecord::Migration[5.2]
  def change
    create_table :arttagfields do |t|
      t.string :name

      t.timestamps
    end
  end
end
