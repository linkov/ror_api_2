class ChangeTokenField < ActiveRecord::Migration[5.2]
  def change
    change_column :lessons, :token, :text 
  end
end
