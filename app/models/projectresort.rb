class Projectresort < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :resortimages, dependent: :destroy

  accepts_nested_attributes_for :resortimages

end
