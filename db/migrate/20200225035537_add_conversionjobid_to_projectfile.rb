class AddConversionjobidToProjectfile < ActiveRecord::Migration[5.2]
  def change
    add_column :projectfiles, :conversionjobid, :string
  end
end
