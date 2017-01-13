class Comment < ApplicationRecord
  validates :body, :commentable_id, :commentable_type, :user_id, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
end
