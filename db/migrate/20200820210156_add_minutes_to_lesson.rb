class AddMinutesToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :minutes, :integer
  end
end
