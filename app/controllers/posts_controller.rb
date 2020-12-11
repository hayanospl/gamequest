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
    posts = Post.where('title LIKE ? OR content LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword].present?
    if params[:tag_name].present? && params[:keyword].present?
      posts = posts.tagged_with(params[:tag_name], :match_all => false)
    elsif params[:tag_name].present?
      posts = Post.includes(:user, :taggings).tagged_with(params[:tag_name], :match_all => false)
    end

    if params[:tag_name].blank? && params[:keyword].blank?
      posts = Post.all.includes(:user, :taggings)
    end

    case params[:sort]

      when 'new'
        posts = posts.order(created_at: :DESC)
        
      when 'old'
        posts = posts.order(created_at: :ASC)
        
      when 'likes'
        posts1 = Array.new
          posts.each do |p|
            if p.likes.count == 0
              posts1.push(p)
            end
          end
        posts2 = posts.find(Like.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
        posts = posts2 + posts1

      when 'dislikes'
        posts1 = Array.new
          posts.each do |p|
            if p.likes.count == 0
              posts1.push(p)
            end
          end 
        posts2 = posts.find(Like.group(:post_id).order(Arel.sql('count(post_id) asc')).pluck(:post_id))
        posts = posts1 + posts2
    end

    if params[:likecount].present?
      post_array = Array.new

        posts.each do |p|
          if p.likes.count >= params[:likecount].to_i
            post_array.push(p)
          end
        end
      posts = post_array
     end

    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)

    if  @posts.blank?
        @posts = Post.none
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
