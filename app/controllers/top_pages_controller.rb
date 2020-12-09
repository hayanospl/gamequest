class TopPagesController < ApplicationController
  def index
    @posts = Post.includes(:user).page(params[:page]).per(10)
  end

  def new
  end
end
