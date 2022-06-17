class AddHeightAndWidthToProjectfile < ActiveRecord::Migration[5.2]
  def change
    add_column :projectfiles, :width, :integer
    add_column :projectfiles, :height, :integer

  end
end
