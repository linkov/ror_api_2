class AddMeetingfinishedToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :meetingfinished, :boolean, default: false
  end
end
