class Projectfile < ApplicationRecord
  belongs_to :project
  belongs_to :avconversion, class_name: 'Avconversion', primary_key: :jobid, foreign_key: :conversionjobid, optional: true
  has_many :avfeedbacklanes
  has_many :tagfeedbacks
  has_many :ratings
end
