class CreateProjectadvisors < ActiveRecord::Migration[5.2]
  def change
    create_table :projectadvisors do |t|
      t.references :project, foreign_key: true
      t.references :myadviser, foreign_key: true
      t.boolean :invitesent, default: false

      t.timestamps
    end
  end
end
