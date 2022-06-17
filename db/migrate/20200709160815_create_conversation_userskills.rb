class CreateConversationUserskills < ActiveRecord::Migration[5.2]
  def change
    create_table :conversation_userskills do |t|
      t.references :conversation, foreign_key: true
      t.references :user_skill, foreign_key: true

      t.timestamps
    end
  end
end
