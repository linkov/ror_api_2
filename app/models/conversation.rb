class Conversation < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  has_many :messages, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :conversation_userskills, dependent: :destroy
  has_many :user_skills, through: :conversation_userskills
  accepts_nested_attributes_for :user_skills

  def user_recipient(user)
    conversation_users.without(user.id).join
  end

  def user_in_conversation?(user)
    conversation_users.include?(user.id)
  end

  private

  def conversation_users
    attributes.slice('sender_id', 'recipient_id').values
  end
end
