class ChangeSettingValueToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :settings, :value, :decimal, :precision => 13, :scale => 2
  end
end
