class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :user_id, presence: true
  validates :title,   presence: true
  validates :content, presence: true
  mount_uploader :image, ImageUploader
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
