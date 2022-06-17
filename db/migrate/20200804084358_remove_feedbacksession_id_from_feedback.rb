class RemoveFeedbacksessionIdFromFeedback < ActiveRecord::Migration[5.2]
  def change
    remove_column :feedbacks, :feedbacksession_id, :integer
    add_column :ratings, :feedbacksession_id, :integer
  end
end
