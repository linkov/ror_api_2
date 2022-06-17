class CreateAdvisordates < ActiveRecord::Migration[5.2]
  def change
    create_table :advisordates do |t|
      t.integer :day
      t.integer :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
