class AddFieldsToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :confirmed, :boolean, default: false
    add_column :lessons, :finished, :boolean, default: false
    add_column :lessons, :paid, :boolean, default: false
  end
end
