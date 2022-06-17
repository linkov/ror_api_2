class ChangeTagFeedbackModel < ActiveRecord::Migration[5.2]
  def change
    remove_reference :tagfeedbacks, :feedback, index: true, foreign_key: true
    add_reference :tagfeedbacks, :projectfile, index: true, foreign_key: true
  end
end
