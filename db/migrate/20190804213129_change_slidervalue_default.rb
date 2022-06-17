class ChangeSlidervalueDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:ratings, :slidervalue, 50)
  end
end
