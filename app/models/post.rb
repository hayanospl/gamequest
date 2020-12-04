class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  validates :user_id, presence: true
  validates :title,   presence: true
  validates :content, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
