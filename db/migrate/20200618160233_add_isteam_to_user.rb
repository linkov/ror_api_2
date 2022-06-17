class AddIsteamToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isteam, :boolean, default: false
  end
end
