class ChangeDefaultValueConfirmedToLessons < ActiveRecord::Migration[5.2]
  def change
    change_column_default :lessons, :confirmed, nil
  end
end
