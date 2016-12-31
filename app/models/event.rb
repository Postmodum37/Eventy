class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :user, :start_date, :end_date, presence: true

  has_attached_file :banner, styles: { medium: '585x585>', thumb: '100x100>' }
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\z/

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
  belongs_to :user
  # def to_param
  #   title
  # end

  def short_description
    return description[0..150] + '...' if description.length > 150
    description
  end
end
