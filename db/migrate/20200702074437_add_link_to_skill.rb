class AddLinkToSkill < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :link, :string
  end
end
