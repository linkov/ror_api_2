class CreateResortimages < ActiveRecord::Migration[5.2]
  def change
    create_table :resortimages do |t|
      t.integer :order
      t.references :projectfile, foreign_key: true
      t.references :projectresort, foreign_key: true

      t.timestamps
    end
  end
end
