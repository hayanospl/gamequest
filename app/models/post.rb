class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :already_reads
  acts_as_taggable
  validates :user_id, presence: true
  validates :title,   presence: true
  validates :content, presence: true
  mount_uploader :image, ImageUploader

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

 
  def already_read?(user)
    already_reads.where(user_id: user.id).exists?
  end

end
