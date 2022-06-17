class RemoveProjectfileFk1 < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:ratings, :projectfile_id)
      remove_foreign_key :ratings, :projectfile_id
    end
  end
end
