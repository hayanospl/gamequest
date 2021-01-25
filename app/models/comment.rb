class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: {maximum: 1000} 
  has_many :comment_likes, dependent: :destroy
  mount_uploader :image, ImageUploader
  def comment_liked_by?(user)
    comment_likes.where(user_id: user.id).exists?
  end
end
