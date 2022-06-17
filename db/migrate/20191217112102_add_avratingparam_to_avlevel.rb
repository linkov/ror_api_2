class AddAvratingparamToAvlevel < ActiveRecord::Migration[5.2]
  def change
    add_reference :avlevels, :avratingparam, foreign_key: true
  end
end
