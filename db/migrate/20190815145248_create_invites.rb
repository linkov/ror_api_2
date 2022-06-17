class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :email
      t.text :message
      t.string :name
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
