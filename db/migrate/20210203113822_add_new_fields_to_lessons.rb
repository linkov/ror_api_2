class AddNewFieldsToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :paymentrequestapproved, :boolean, default: false
    add_column :lessons, :paymentrequestdenied, :boolean, default: false
  end
end
