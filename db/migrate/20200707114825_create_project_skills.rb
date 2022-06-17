class CreateProjectSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :project_skills do |t|
      t.references :project, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
