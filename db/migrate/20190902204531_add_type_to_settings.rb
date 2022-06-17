class AddTypeToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :settingtype, :string
  end
end
