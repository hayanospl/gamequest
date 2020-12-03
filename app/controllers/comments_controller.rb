class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    #@comment.name = current_user.name
    if @comment.save
      redirect_to post_path(@post.id)
    else
      redirect_to root_path
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
