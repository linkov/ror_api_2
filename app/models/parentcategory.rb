class Parentcategory < ApplicationRecord
  belongs_to :artfield
  has_many :categories, dependent: :destroy
end
