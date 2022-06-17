class CreateNewsfeedfollows < ActiveRecord::Migration[5.2]
  def change
    create_table :newsfeedfollows do |t|
      t.integer :user_id
      t.integer :artist_id
      t.integer :commenter_id

      t.timestamps
    end
  end
end
