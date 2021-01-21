class TopPagesController < ApplicationController
  def index
    @posts = Post.includes(:user, :taggings).order("created_at DESC").page(params[:page]).per(DEFAULT_PAGE_ITEM_COUNT)

    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").includes(:user, :taggings).page(params[:page]).per(DEFAULT_PAGE_ITEM_COUNT)
    end

    if user_signed_in?
      @recommend_tag   = Posts::Postservices.recommend_tag(current_user)
      @recommend_posts = Posts::Postservices.recommend_posts(current_user, @recommend_tag, params).includes(:user, :taggings)
    end

  end


  def new
  end

end
