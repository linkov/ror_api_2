class AddSpecialToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :special, :boolean, default: false
  end
end
