class Feedbacksession < ApplicationRecord
    has_many :ratings
    accepts_nested_attributes_for :ratings
end
