class AddMeetingtimeToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :meetingtime, :datetime
  end
end
