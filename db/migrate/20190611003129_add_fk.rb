class AddFk < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :category, index: true
  end
end
