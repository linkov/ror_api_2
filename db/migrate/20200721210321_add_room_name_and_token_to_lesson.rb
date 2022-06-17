class AddRoomNameAndTokenToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :name, :string
    add_column :lessons, :token, :string
  end
end
