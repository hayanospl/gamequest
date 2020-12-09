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
    @post = current_user.posts.find(params[:post_id])
    @post.destroy
    redirect_to root_path
  end

  def search
    if params[:keyword].present?
      posts = Post.includes(:user).references(:users).where('title LIKE ? OR content LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      posts_array = posts.to_a
      @posts = Kaminari.paginate_array(posts_array).page(params[:page]).per(10)
    end
    
    if params[:likecount].present?
      if params[:keyword].present?
        posts_all = posts
      else
        posts_all = Post.includes(:user)
      end

      post_array = Array.new

      posts_all.each do |p|
        if p.likes.count >= params[:likecount].to_i
          post_array.push(p)
        end
      end

      @posts = Kaminari.paginate_array(post_array).page(params[:page]).per(10)
    end

    if @posts.nil?
      @posts = Post.none
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
