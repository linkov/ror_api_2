class Artcategory < ApplicationRecord
  has_many :subcategories, :class_name => "Artcategory", :foreign_key => "parent_id", :dependent => :destroy
  has_many :projects
  belongs_to :parent, :class_name => "Artcategory", optional: true
end
