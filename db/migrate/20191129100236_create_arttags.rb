class CreateArttags < ActiveRecord::Migration[5.2]
  def change
    create_table :arttags do |t|
      t.string :name

      t.timestamps
    end
  end
end
