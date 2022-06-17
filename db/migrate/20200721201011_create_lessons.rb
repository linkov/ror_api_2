class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.datetime :start
      t.datetime :end
      t.integer :teacher_id
      t.integer :student_id
      t.integer :pronunciation_rate
      t.integer :knowledge_rate
      t.integer :explanation_rate
      t.text :positive_comment
      t.text :negartive_comment

      t.timestamps
    end
  end
end
