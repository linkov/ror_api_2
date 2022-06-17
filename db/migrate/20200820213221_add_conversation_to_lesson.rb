class AddConversationToLesson < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :conversation, foreign_key: true
  end
end
