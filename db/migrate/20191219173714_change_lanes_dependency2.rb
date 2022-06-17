class ChangeLanesDependency2 < ActiveRecord::Migration[5.2]
  def change
    add_reference :avfeedbacklanes, :rating, index: true, foreign_key: true
  end
end
