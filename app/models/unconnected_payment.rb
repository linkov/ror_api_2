class UnconnectedPayment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, :student_id, presence: true
end
