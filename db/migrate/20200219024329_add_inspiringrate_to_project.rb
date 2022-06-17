class AddInspiringrateToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :inspiringrate, :decimal, :default => 200
  end
end
