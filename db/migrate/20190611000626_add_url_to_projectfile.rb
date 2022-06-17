class AddUrlToProjectfile < ActiveRecord::Migration[5.2]
  def change
    add_column :projectfiles, :url, :string
  end
end
