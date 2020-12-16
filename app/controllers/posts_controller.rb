class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def index
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
    posts = Post.includes(:user, :taggings).where('title LIKE ? OR content LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%") if params[:keyword].present?
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
        posts = posts.select('posts.*', 'count(likes.id) AS likes')
                      .left_joins(:likes)
                      .group('posts.id')
                      .order('likes desc')
                      .order('created_at desc')
                      
      when 'dislikes'
        posts = posts.select('posts.*', 'count(likes.id) AS likes')
                      .left_joins(:likes)
                      .group('posts.id')
                      .order('likes asc')
                      .order('created_at desc')
    end

    if params[:likecount].present?
      post_array = Array.new

      case params[:inequality]

        when 'greater'
          posts.each do |p|
            if p.likes.count >= params[:likecount].to_i
              post_array.push(p)
            end
          end
        posts = post_array

        when 'less'
          posts.each do |p|
            if p.likes.count <= params[:likecount].to_i
              post_array.push(p)
            end
          end
        posts = post_array
      end

    end

    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)

    if  @posts.blank?
        @posts = Post.none
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list)
  end
end
