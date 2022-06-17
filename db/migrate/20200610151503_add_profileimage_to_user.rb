class AddProfileimageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profileimage, :string
  end
end
