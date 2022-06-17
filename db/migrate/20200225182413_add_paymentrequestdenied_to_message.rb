class AddPaymentrequestdeniedToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :paymentrequestdenied, :boolean, default: false
  end
end
