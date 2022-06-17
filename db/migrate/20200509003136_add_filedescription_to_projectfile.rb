class AddFiledescriptionToProjectfile < ActiveRecord::Migration[5.2]
  def change
    add_column :projectfiles, :filedescription, :text
  end
end
