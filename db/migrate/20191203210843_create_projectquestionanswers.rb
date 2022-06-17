class CreateProjectquestionanswers < ActiveRecord::Migration[5.2]
  def change
    create_table :projectquestionanswers do |t|
      t.references :project, foreign_key: true
      t.text :answer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
