class Category < ApplicationRecord
  has_one :project
  belongs_to :parentcategory
end
