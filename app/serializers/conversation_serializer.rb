class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :istutoring, :advisorrate, :lastmeetingtime, :created_at, :project_id, :projectfile_id, :recipient_id, :sender_id, :sender, :recipient, :last_message_time, :unread_message_count, :lastmeetingconfirmed, :lastmeetingfinished, :lastmeetingpaid, :isclarification
  has_one :project
  has_many :messages
  has_many :conversation_userskills
  has_many :lessons
  
  def lastmeetingpaid
    last_lesson = object.lessons.last
    if last_lesson
      last_lesson.paid
    end
  end

  def istutoring
    object.lessons.count > 0
  end

  def lastmeetingfinished
    last_lesson = object.lessons.last
    if last_lesson
      last_lesson.finished
    end
  end


  def lastmeetingconfirmed
    last_lesson = object.lessons.last
    if last_lesson && last_lesson.confirmed
      last_lesson.confirmed
    end
  end

  def lastmeetingtime
  
    last_lesson = object.lessons.last
    if last_lesson
      last_lesson.meetingtime
    end

  end

  def unread_message_count
    object.messages.where(:read => false).count
  end

  def last_message_time

    if object.messages.length && object.messages.last
        object.messages.last.created_at
      else
        Time.zone.now
    end

  end


  def sender
    User.find_by_id(object.sender_id)
  end

  def recipient
    User.find_by_id(object.recipient_id)
  end

end
