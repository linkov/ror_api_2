class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :projectfile , optional: true
  belongs_to :feedbacksession, optional: true
  has_many :feedbacks, dependent: :destroy
  has_many :avfeedbacklanes, dependent: :destroy

  accepts_nested_attributes_for :feedbacks
  accepts_nested_attributes_for :avfeedbacklanes


end
