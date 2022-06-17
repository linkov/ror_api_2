class Message < ApplicationRecord
  attribute :updated, :boolean, default: false

  belongs_to :conversation
  belongs_to :user
end
