class CardSerializer < ActiveModel::Serializer
  attributes :id, :imageurl, :text, :title, :active
end
