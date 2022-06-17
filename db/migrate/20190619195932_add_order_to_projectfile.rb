class AddOrderToProjectfile < ActiveRecord::Migration[5.2]
  def change
    add_column :projectfiles, :order, :integer
  end
end
