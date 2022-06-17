class AddFiendsToFeedback < ActiveRecord::Migration[5.2]
  def change
    add_reference :feedbacks, :avratingparam, foreign_key: false
    add_column :feedbacks, :avtracktimeposition, :float
  end
end
