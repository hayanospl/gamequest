class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post.id)
    else
      redirect_to request.referrer
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:comment_id])
    @comment.destroy
    redirect_to request.referrer || root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :image)
  end
end
