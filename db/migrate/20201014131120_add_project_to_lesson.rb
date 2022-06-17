class AddProjectToLesson < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :project, foreign_key: false
  end
end
