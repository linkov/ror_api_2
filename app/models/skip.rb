class Skip < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :artcategory
end
