class DropTransactionTyoe < ActiveRecord::Migration[5.2]
  def change
    drop_table :transaction_types
  end
end
