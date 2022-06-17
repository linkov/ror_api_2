class RemoveTransactionTypeFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :transaction_type_id, :integer
  end
end
