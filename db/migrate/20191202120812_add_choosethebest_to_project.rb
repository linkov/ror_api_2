class AddChoosethebestToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :choosethebest, :boolean, default: false
  end
end
