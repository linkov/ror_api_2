class CreateJoinTableUsersCards < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :cards do |t|
      # t.index [:user_id, :card_id]
      # t.index [:card_id, :user_id]
    end
  end
end
