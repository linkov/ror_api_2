class CreateFeedbacksessions < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacksessions do |t|
      t.integer :paymentamount
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
