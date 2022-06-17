class CreateSkips < ActiveRecord::Migration[5.2]
  def change
    create_table :skips do |t|
      t.references :user, foreign_key: true
      t.datetime :skiptime
      t.references :project, foreign_key: true
      t.references :category, foreign_key: false
      t.references :parentcategory, foreign_key: false

      t.timestamps
    end
  end
end
