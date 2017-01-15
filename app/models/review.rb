class Review < ApplicationRecord
  validates :user_id, :event_id, :rating, presence: true
  validates :rating, inclusion: 1..5, allow_nil: false
  belongs_to :user
  belongs_to :event

  def self.reviewed_event?(event)
    return true if where(event: event).count > 0
    false
  end
end
