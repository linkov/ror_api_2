class RemoveProjectFkFromConversation < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:conversations, :projects)
      remove_foreign_key :conversations, column: :project_id
    end
  end
end
