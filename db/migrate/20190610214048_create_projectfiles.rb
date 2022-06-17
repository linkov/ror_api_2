class CreateProjectfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :projectfiles do |t|
      t.string :name
      t.string :handle
      t.string :mimetype
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
