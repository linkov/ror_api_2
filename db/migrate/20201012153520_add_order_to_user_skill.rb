class AddOrderToUserSkill < ActiveRecord::Migration[5.2]
  def change
    add_column :user_skills, :order, :integer
  end
end
