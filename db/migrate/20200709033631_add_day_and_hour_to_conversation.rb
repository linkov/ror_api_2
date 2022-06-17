class AddDayAndHourToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :day, :integer
    add_column :conversations, :hour, :integer
  end
end
