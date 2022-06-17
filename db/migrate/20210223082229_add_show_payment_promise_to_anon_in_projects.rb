class AddShowPaymentPromiseToAnonInProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :show_payment_promise_to_anon, :boolean, default: false
  end
end
