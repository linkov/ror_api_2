class AddCategoryrelationToRating < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :categoryrelation_id, :integer
  end
end
