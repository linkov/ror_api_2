class AddProjectfileToConversation < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :projectfile, foreign_key: false
  end
end
