class AddSentToInvite < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :sent, :boolean, default: false
  end
end
