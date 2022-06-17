class ChangeAdvisorrateDefaultToCents < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :advisorrate, from: 5, to: 500)
  end
end
