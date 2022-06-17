class ChangeMessageToUtf8mb4InInvites < ActiveRecord::Migration[5.2]
  def up
    execute "ALTER TABLE invites CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE invites MODIFY message TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end

  def down
    execute "ALTER TABLE invites CONVERT TO CHARACTER SET utf8 COLLATE utf8_bin"
    execute "ALTER TABLE invites MODIFY message TEXT CHARACTER SET utf8 COLLATE utf8_bin"
  end
end
