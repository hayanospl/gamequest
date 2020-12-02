class CommentsController < ApplicationController
  def create
    #@post = Post.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save #今の段階では保存が成功したらホーム、失敗したらプロフィール画面にいくようにしてます
      redirect_to root_path
    else
      redirect_to users_show_path
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
