class AddShowtutorialsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :showtutorials, :boolean, default: false
  end
end
