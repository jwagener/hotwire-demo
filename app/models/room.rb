class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  broadcasts

  def broadcast_counts
    # TODO how to make these channels secure, so we don't broadcast to unauthorized users?
    Turbo::StreamsChannel.broadcast_replace_to "total_count", target: "total_count", partial: "rooms/total_count", locals: {text: "#{Message.all.count}"}
    Turbo::StreamsChannel.broadcast_replace_to "room_#{id}_count", target: "room_#{id}_count", partial: "rooms/room_count", locals: {room: self, text: "#{messages.count}"}
  end

end
