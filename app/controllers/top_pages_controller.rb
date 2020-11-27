class TopPagesController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all
  end

  def new
  end
end
