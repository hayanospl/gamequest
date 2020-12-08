class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def index
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @posts = Post.all
    if @post.save
      redirect_to root_path 
    else
      render new_post_path
    end
  end

  def destroy
    @post = current_user.posts.find(id: params[:post_id])
    @post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
