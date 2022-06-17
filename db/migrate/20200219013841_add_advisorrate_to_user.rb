class AddAdvisorrateToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :advisorrate, :decimal, :default => 5.00
  end
end
