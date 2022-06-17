class RemoveHourDayFromConversation < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversations, :day, :integer
    remove_column :conversations, :hour, :integer
  end
end
