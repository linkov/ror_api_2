class CreateAvfeedbacklanes < ActiveRecord::Migration[5.2]
  def change
    create_table :avfeedbacklanes do |t|
      t.references :rating, foreign_key: true
      t.references :avratingparam, foreign_key: true

      t.timestamps
    end
  end
end
