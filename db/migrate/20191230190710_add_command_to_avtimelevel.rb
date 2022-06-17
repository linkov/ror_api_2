class AddCommandToAvtimelevel < ActiveRecord::Migration[5.2]
  def change
    add_column :avtimelevels, :command, :string
  end
end
