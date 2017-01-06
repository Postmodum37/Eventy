class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: '300x300#', thumb: '100x100#', medium_small: '200x200#', comment_avatar: '60x60#' }, default_url: '/images/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :events
  has_many :reviews
  has_many :comments
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  def full_name
    "#{first_name} #{last_name}"
  end

  def registered_to_event?(event)
    return true if EventRegistration.where(user_id: id, event_id: event.id).count > 0
    false
  end

  def eligible_to_vote?(event)
    return true if registered_to_event?(event) && EventRegistration.where(user_id: id, event_id: event.id).last.confirmed?
    false
  end
end
