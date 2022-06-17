class AddInsightscategoryToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :insightscategory, :string, :default => "Inspiring"
    remove_column :users, :insightscategory
  end
end
