class AddLikecountToProjectfile < ActiveRecord::Migration[5.2]
  def change
    add_column :projectfiles, :likecount, :integer, default: 0
  end
end
