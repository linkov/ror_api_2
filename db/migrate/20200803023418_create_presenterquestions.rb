class CreatePresenterquestions < ActiveRecord::Migration[5.2]
  def change
    create_table :presenterquestions do |t|
      t.references :project, foreign_key: true
      t.text :title

      t.timestamps
    end
  end
end
