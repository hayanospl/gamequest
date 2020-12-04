class CommentLikesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    current_user.comment_likes.create(comment_id: params[:comment_id], user_id: current_user.id)
    redirect_to post_path(@comment.post.id)
  end

  def destroy
    @like = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @like.destroy
    redirect_to post_path
  end
end
