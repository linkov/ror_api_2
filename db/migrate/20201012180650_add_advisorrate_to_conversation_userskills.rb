class AddAdvisorrateToConversationUserskills < ActiveRecord::Migration[5.2]
  def change
    add_column :conversation_userskills, :advisorrate, :integer
  end
end
