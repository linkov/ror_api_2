class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :story, foreign_key: true
      t.string :imageurl
      t.text :text
      t.string :title
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
