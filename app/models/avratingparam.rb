class Avratingparam < ApplicationRecord
  belongs_to :project
  has_many :avfeedbacklanes, dependent: :destroy
  has_one :feedback
end
