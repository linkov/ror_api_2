class RemoveFk < ActiveRecord::Migration[5.2]
  def change
    remove_reference :categories, :project, index: true, foreign_key: true
  end
end
