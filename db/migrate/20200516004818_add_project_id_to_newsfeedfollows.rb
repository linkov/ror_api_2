class AddProjectIdToNewsfeedfollows < ActiveRecord::Migration[5.2]
  def change
    add_column :newsfeedfollows, :project_id, :integer
  end
end
