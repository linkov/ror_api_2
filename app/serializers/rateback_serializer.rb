class RatebackSerializer < ActiveModel::Serializer
  attributes :id, :value
  has_one :feedback
end
