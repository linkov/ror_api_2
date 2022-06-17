class CreateAvconversions < ActiveRecord::Migration[5.2]
  def change
    create_table :avconversions do |t|
      t.string :jobid
      t.string :url
      t.string :thumb

      t.timestamps
    end
  end
end
