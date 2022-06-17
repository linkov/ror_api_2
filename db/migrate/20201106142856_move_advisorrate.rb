class MoveAdvisorrate < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversation_userskills, :advisorrate, :integer
    add_column :conversations, :advisorrate, :integer
  end
end
