class AddPaymentToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :paymentrequestamount, :integer
    add_column :messages, :paymentrequestapproved, :boolean, default: false
  end
end
