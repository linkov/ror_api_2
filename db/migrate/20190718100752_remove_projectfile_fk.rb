class RemoveProjectfileFk < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:ratings, :projectfile)
      remove_foreign_key :ratings, :projectfile
    end
  end
end
