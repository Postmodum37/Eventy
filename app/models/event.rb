class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :user, :start_date, :end_date, :address, :city, :street, :lat, :lng,
            :contact_phone, :category, :place, :max_participants, presence: true
  validates :min_participants, :max_participants, numericality: true
  validates :contact_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

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

  def self.search(params)
    search = all
    search = search.where(category: params[:category]) if params[:category].present?
    search = search.where(place: params[:place]) if params[:place].present?

    search = search.where('title LIKE ?', "%#{params[:title]}%") if params[:title].present?
    search = search.where('address LIKE ?', "%#{params[:address]}%") if params[:address].present?
    search
  end
end
