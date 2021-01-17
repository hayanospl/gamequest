class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def index
    @posts = Posts::Postservices.search(params)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    unless @post.already_read?(current_user)
      current_user.already_reads.create(post_id: @post.id)
    end
    @comment = Comment.new
    # binding.pry
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path 
    else
      render new_post_path
    end
  end

  def destroy
    @post = current_user.posts.find(params[:post_id])
    @post.destroy
    redirect_to root_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list)
  end
end
