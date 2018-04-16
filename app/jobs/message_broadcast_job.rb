class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    data = { message: message.content,
             user: message.user.name,
             created_at: message.created_at.strftime("%d/%m/%Y") }
    ActionCable.server.broadcast "room_channel", chat: data
  end
end
