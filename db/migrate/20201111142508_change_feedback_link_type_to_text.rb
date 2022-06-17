class ChangeFeedbackLinkTypeToText < ActiveRecord::Migration[5.2]
  def change
    change_column :feedbacks, :link, :text 
  end
end
