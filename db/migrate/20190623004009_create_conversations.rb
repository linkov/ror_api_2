class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :project, foreign_key: true
      t.references :sender
      t.references :recipient
      t.timestamps
    end
  end
end
