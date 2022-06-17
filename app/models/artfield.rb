class Artfield < ApplicationRecord
  has_many :parentcategories, dependent: :destroy
  accepts_nested_attributes_for :parentcategories
end
