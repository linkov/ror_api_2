class RenameMinutesToSeconds < ActiveRecord::Migration[5.2]
  def change
    rename_column :lessons, :minutes, :seconds
  end
end
