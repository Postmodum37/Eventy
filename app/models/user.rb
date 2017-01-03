class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: '300x300#', thumb: '100x100#', medium_small: '200x200#', comment_avatar: '60x60#' }, default_url: 'missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :events
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  def full_name
    "#{first_name} #{last_name}"
  end
end
