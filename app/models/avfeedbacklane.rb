class Avfeedbacklane < ApplicationRecord
  belongs_to :projectfile
  belongs_to :rating
  belongs_to :avratingparam
  has_many :avtimelevels, dependent: :destroy
  accepts_nested_attributes_for :avtimelevels
end
