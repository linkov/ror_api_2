class AddMeetingtimeToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :meetingtime, :datetime
  end
end
