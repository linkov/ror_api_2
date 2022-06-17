class ChangeLanesDependency < ActiveRecord::Migration[5.2]
  def change
    remove_reference :avfeedbacklanes, :rating, index: true, foreign_key: true
    add_reference :avfeedbacklanes, :projectfile, index: true, foreign_key: true
  end
end
