class AddColorToAvratingparam < ActiveRecord::Migration[5.2]
  def change
    add_column :avratingparams, :color, :string
  end
end
