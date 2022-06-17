class AddSharetokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sharetoken, :string
  end
end
