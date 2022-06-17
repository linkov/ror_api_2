class ChangeTypeToFeedbackType < ActiveRecord::Migration[5.2]
  def change
    rename_column :feedbacks, :type, :feedbacktype
  end
end
