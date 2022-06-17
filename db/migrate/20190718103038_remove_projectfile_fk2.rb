class RemoveProjectfileFk2 < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:ratings, :projectfiles)
      remove_foreign_key :ratings, :projectfiles
    end
  end
end
