class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :user, :start_date, :end_date, presence: true

  CATEGORY_LT = ['spektakliai', 'koncertai', 'seminarai', 'parodos', 'premjeros',
                 'sportas', 'mokymai', 'vakareliai', 'iniciatyvos', 'vaikams',
                 'festivaliai', 'kita']
  CATEGORY_EN = ['theatricals', 'concerts', 'seminars', 'exhibition', 'premieres',
                 'sport', 'training', 'parties', 'initiatives', 'children', 'festivals']

  belongs_to :user
  # def to_param
  #   title
  # end

  def short_description
    return description[0..150] + '...' if description.length > 150
    description
  end
end
