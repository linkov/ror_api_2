class CreateUnconnectedPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :unconnected_payments do |t|
      t.references :user, foreign_key: true
      t.integer :student_id
      t.integer :project_id

      t.timestamps
    end
  end
end
