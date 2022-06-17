class AddArttagfieldToArttag < ActiveRecord::Migration[5.2]
  def change
    add_reference :arttags, :arttagfield, foreign_key: true
  end
end
