class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.text :text
      t.integer :order
      t.string :type
      t.string :link
      t.references :rating, foreign_key: true

      t.timestamps
    end
  end
end
