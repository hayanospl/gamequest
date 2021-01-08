class UsersController < ApplicationController
before_action :authenticate_user!, only: [:show]
  def show
    @user = current_user
    @user_posts = @user.posts.includes(:taggings).order("created_at DESC").page(params[:page]).per(10)
    @likes = @user.likes.order("created_at DESC").page(params[:page]).per(10)
    @following_posts = Post.includes(:user, :taggings).where(user_id: @user.followings.ids).order("created_at DESC").page(params[:page]).per(10)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to users_show_path
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile, :image)
  end
end
