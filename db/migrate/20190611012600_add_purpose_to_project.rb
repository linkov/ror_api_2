class AddPurposeToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :purpose, :string
  end
end
