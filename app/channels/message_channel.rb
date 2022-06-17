class MessageChannel < ApplicationCable::Channel
  def self.broadcast(room, data)
    ActionCable.server.broadcast(room, data)
  end

  def subscribed
    stream_from params[:room]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
