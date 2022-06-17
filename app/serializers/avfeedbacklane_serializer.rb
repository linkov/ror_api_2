class AvfeedbacklaneSerializer < ActiveModel::Serializer
  attributes :id, :avtimelevels, :color
  has_one :rating
  has_one :avratingparam

  def avtimelevels
    object.avtimelevels.order(:order)
  end

  def color
    param = Avratingparam.find(object.avratingparam_id).color
  end
end
