class CreateRatebacks < ActiveRecord::Migration[5.2]
  def change
    create_table :ratebacks do |t|
      t.references :feedback, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
