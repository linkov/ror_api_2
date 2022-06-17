class AddOrderToAvtimelevel < ActiveRecord::Migration[5.2]
  def change
    add_column :avtimelevels, :order, :integer
  end
end
