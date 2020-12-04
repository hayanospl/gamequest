class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comment_likes

  def comment_liked_by?(user)
    comment_likes.where(user_id: user.id).exists?
  end
end