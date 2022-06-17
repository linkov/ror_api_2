class ChangeOrderToUserSkillDefault < ActiveRecord::Migration[5.2]
  change_column_default(:user_skills, :order, 0)
end
