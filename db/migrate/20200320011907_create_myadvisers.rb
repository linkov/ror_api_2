class CreateMyadvisers < ActiveRecord::Migration[5.2]
  def change
    create_table :myadvisers do |t|
      t.references :user, foreign_key: true
      t.integer :adviserid

      t.timestamps
    end
  end
end
