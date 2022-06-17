class AddMeetingconfirmedToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :meetingconfirmed, :boolean, default: false
  end
end
