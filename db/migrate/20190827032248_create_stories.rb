class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :flow
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
