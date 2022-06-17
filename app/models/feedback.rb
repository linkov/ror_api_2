class Feedback < ApplicationRecord
  belongs_to :rating
  belongs_to :avratingparam, optional: true
  has_many :ratebacks, dependent: :destroy

  delegate :user, to: :rating
end
