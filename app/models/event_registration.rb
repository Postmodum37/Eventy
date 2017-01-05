class EventRegistration < ApplicationRecord
  validates :event_id, :user_id, presence: true
  belongs_to :user
  belongs_to :event

  scope :approved, -> { where(confirmed: true) }
  scope :denied, -> { where(confirmed: false) }
  scope :pending, -> { where(confirmed: nil) }
end
