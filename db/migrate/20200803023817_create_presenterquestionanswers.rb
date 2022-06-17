class CreatePresenterquestionanswers < ActiveRecord::Migration[5.2]
  def change
    create_table :presenterquestionanswers do |t|
      t.references :presenterquestion, foreign_key: true
      t.text :answer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
