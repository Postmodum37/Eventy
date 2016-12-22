class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :user, :start_date, :end_date, presence: true

  belongs_to :user
  # def to_param
  #   title
  # end
end
