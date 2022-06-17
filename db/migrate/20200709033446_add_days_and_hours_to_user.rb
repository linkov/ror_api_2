class AddDaysAndHoursToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :days, :string
    add_column :users, :hours, :string
  end
end
