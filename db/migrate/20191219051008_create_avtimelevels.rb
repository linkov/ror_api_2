class CreateAvtimelevels < ActiveRecord::Migration[5.2]
  def change
    create_table :avtimelevels do |t|
      t.float :timeposition
      t.integer :level
      t.references :avfeedbacklane, foreign_key: true

      t.timestamps
    end
  end
end
