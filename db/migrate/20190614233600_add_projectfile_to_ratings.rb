class AddProjectfileToRatings < ActiveRecord::Migration[5.2]
  def change
    add_reference :ratings, :projectfile, foreign_key: true
  end
end
