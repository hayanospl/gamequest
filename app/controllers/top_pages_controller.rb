class TopPagesController < ApplicationController
  def index
    @posts = Post.includes(:user, :taggings).page(params[:page]).per(10)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").includes(:user, :taggings).page(params[:page]).per(10)
    end
  end

  def new
  end
end
