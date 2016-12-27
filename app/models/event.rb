class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :user, :start_date, :end_date, presence: true

  belongs_to :user
  # def to_param
  #   title
  # end

  def short_description
    return description[0..150] + '...' if description.length > 150
    description
  end
end
