class AddShortnameToSkill < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :shortname, :string
  end
end
