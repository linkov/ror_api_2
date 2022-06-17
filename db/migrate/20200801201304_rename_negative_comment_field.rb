class RenameNegativeCommentField < ActiveRecord::Migration[5.2]
  def change
    rename_column :lessons, :negartive_comment, :negative_comment
  end
end
