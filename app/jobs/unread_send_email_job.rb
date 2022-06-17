class UnreadSendEmailJob < ApplicationJob
  queue_as :default

  def perform(message)
    return if message.read

    MandrillUserMailer.sendVideoLessonRequestEmail(message, opts={}).deliver
  end
end
