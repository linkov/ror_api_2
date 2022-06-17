class AddRatingtypeToRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :ratingtype, :string
  end
end
