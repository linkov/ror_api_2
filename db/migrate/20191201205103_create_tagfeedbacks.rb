class CreateTagfeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :tagfeedbacks do |t|
      t.references :feedback, foreign_key: true
      t.references :arttag, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
