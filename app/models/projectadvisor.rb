class Projectadvisor < ApplicationRecord
  belongs_to :project
  has_one :myadviser
end
