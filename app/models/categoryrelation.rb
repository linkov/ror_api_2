class Categoryrelation < ApplicationRecord
  has_one :tocategory, :class_name => 'Category'
  has_one :fromcategory, :class_name => 'Category'
  has_one :toparentcategory, :class_name => 'Parentcategory'
  has_one :fromparentcategory, :class_name => 'Parentcategory'
end
