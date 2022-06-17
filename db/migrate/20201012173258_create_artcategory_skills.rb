class CreateArtcategorySkills < ActiveRecord::Migration[5.2]
  def change
    create_table :artcategory_skills do |t|
      t.references :artcategory, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
