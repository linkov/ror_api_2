class AddisclarificationToConversation < ActiveRecord::Migration[5.2]
  def change
      add_column :conversations, :isclarification, :boolean, default: false
  end
end
