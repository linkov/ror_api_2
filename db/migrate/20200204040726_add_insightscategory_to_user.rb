class AddInsightscategoryToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :insightscategory, :string, :default => "Inspiring"
  end
end
