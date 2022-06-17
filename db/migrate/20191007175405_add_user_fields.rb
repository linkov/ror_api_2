class AddUserFields < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer, default: 0
    add_column :users, :signup_form_shown, :boolean, default: false
  end
end
