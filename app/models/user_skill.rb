class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_many :conversation_userskills, dependent: :destroy
  has_many :conversations, through: :conversation_userskills, dependent: :destroy
end
