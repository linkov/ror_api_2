class Avconversion < ApplicationRecord
  has_one :projectfile, class_name: 'Projectfile', foreign_key: :conversionjobid, foreign_key: :jobid
end
