class AddNameToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :name, :string
  end
end
