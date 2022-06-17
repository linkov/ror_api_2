class AddRatedToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :rated, :boolean, default: false
  end
end
