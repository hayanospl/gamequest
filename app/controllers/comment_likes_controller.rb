class CommentLikesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    unless @comment.comment_liked_by?(current_user)
      @like = current_user.comment_likes.create(comment_id: params[:comment_id], user_id: current_user.id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @like = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @like.destroy
  end
end
