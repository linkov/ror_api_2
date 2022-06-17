class AddDrawingToFeedback < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :drawing, :text
  end
end
