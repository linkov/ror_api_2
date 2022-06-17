class AddPresenterquestionToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :presenterquestion, :text
  end
end
