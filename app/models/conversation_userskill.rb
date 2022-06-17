class ConversationUserskill < ApplicationRecord
  belongs_to :conversation
  belongs_to :user_skill
end
