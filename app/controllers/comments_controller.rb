class CommentsController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post.id)
    else
      redirect_to root_path
    end

  end

  def destroy
    @comment.destroy
    redirect_to request.referrer || root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :image)
  end

  def correct_user
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find_by(id: params[:comment_id])
    redirect_to post_path(@post.id) if @comment.nil?
  end
end
