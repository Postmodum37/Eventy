class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :user, :start_date, :end_date, :address, :city, :street, :lat, :lng,
            :contact_phone, :category, :place, :max_participants, presence: true
  validates :min_participants, :max_participants, numericality: true
  validates :contact_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validate :end_date_after_start_date
  validate :start_date_after_or_now

  has_attached_file :banner, styles: { medium: '585x500#', thumb: '100x100>' }
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\z/

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :event_registrations, dependent: :destroy
  has_many :reviews, dependent: :destroy

  scope :by_category, ->(category) { where(category: category) }
  scope :by_place, ->(place) { where(place: place) }

  CATEGORIES = ['theatricals', 'concerts', 'seminars', 'exhibition', 'premieres',
                'sport', 'training', 'parties', 'initiatives', 'children', 'festivals',
                'other']
  PLACES = ['outdoor_spaces', 'art_spaces', 'restaurants', 'scientific_institutions',
            'conference_halls', 'other_institutions', 'bars', 'hotels', 'places_to_visit',
            'commercial_spaces', 'sports_centers', 'museums', 'concert_halls',
            'historical_objects', 'cafes', 'locations', 'night_clubs', 'libraries',
            'night_bars', 'amusement_parks', 'theatres', 'self_development_centers',
            'dance_studios', 'sports_arenas', 'spas', 'religious_institutions', 'bowling',
            'cinemas', 'state_institutions', 'medical_institutions', 'other']

  # def to_param
  #   title
  # end

  def short_description
    return description[0..150] + '...' if description.length > 150
    description
  end

  def mine?(current_user)
    return true if user == current_user
    false
  end

  def capacity
    max_participants
  end

  def open_spot_left?
    return true if capacity >= event_registrations.approved.count + 1
    false
  end

  def over?
    return true if Time.zone.now >= end_date
    false
  end

  def available_for_edit?
    return true if (start_date - 1.day) >= Time.zone.now
    false
  end

  def self.search(params)
    search = all
    search = search.where(category: params[:category]) if params[:category].present?
    search = search.where(place: params[:place]) if params[:place].present?

    search = search.where('title LIKE ?', "%#{params[:title]}%") if params[:title].present?
    search = search.where('address LIKE ?', "%#{params[:address]}%") if params[:address].present?
    search
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, 'must be after the start date') if end_date <= start_date
  end

  def start_date_after_or_now
    return if end_date.blank? || start_date.blank?
    errors.add(:start_date, 'must be set in the future') if start_date < Time.zone.now
  end
end
