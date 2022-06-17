class ChangeAdvisorrateDefaultToCents1 < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :advisorrate, 500)
  end
end
