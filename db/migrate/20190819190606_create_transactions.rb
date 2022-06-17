class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :type
      t.decimal :value, :precision => 13, :scale => 2
      t.references :user, foreign_key: true
      t.references :transaction_type, foreign_key: true

      t.timestamps
    end
  end
end
