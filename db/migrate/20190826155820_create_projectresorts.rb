class CreateProjectresorts < ActiveRecord::Migration[5.2]
  def change
    create_table :projectresorts do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
