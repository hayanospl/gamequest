class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :already_reads, dependent: :destroy
  acts_as_taggable
  validates :user_id, presence: true
  validates :title,   presence: true, length: {maximum: 200}
  validates :content, presence: true, length: {maximum: 2000}
  mount_uploader :image, ImageUploader

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

 
  def already_read?(user)
    already_reads.where(user_id: user.id).exists?
  end

end
