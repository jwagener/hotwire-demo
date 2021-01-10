class Message < ApplicationRecord
  belongs_to :room
  broadcasts_to :room
  after_create :broadcast_counts

  def broadcast_counts
    room.broadcast_counts
  end
end
