class UpdateUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :website, :string
    add_column :users, :city, :string
    add_column :users, :showimage, :boolean, default: false
    add_column :users, :showcity, :boolean, default: false
    add_column :users, :showname, :boolean, default: false
    add_column :users, :showwebsite, :boolean, default: false
  end
end
