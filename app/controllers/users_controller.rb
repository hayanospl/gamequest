class UsersController < ApplicationController
before_action :authenticate_user!, only: [:show]
  def show
    @user = current_user
    @user_posts = @user.posts.includes(:taggings).order("created_at DESC").page(params[:page]).per(DEFAULT_PAGE_ITEM_COUNT)
    @likes = @user.likes.order("created_at DESC").page(params[:page]).per(DEFAULT_PAGE_ITEM_COUNT)
    @following_posts = Post.includes(:user, :taggings).where(user_id: @user.followings.ids).order("created_at DESC").page(params[:page]).per(DEFAULT_PAGE_ITEM_COUNT)
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


  def guest
    user = User.find_by(email: 'test@test.test')
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile, :image)
  end
end
