class RemoveavlevelTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :avlevels
  end
end
