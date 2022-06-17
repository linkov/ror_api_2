class RenameTypeToTransactionType < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :type, :transactiontype
  end
end
