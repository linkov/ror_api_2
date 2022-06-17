class DeleteDaysAndHoursFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :days, :integer
    remove_column :users, :hours, :integer
  end
end
