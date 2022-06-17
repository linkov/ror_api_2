class CreateParentcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :parentcategories do |t|
      t.string :name
      t.string :tag

      t.timestamps
    end
  end
end
