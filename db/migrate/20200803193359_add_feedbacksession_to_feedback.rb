class AddFeedbacksessionToFeedback < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :feedbacksession_id, :integer
  end
end
