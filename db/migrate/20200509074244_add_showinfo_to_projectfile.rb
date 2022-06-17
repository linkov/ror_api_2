class AddShowinfoToProjectfile < ActiveRecord::Migration[5.2]
  def change
    add_column :projectfiles, :showinfo, :boolean, default: false
  end
end
