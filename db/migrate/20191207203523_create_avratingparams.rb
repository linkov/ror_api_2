class CreateAvratingparams < ActiveRecord::Migration[5.2]
  def change
    create_table :avratingparams do |t|
      t.string :name
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
