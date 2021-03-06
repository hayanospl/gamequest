class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:follow_id])
    current_user.follow(@user)
    flash[:success] = 'フォローしました'
    redirect_to request.referrer
  end

  def destroy
    @user = User.find(params[:follow_id])
    current_user.unfollow(@user)
    flash[:success] = 'フォローを解除しました'
    redirect_to request.referrer
  end

  def followings
    @user = current_user
    @followings = User.find(current_user.followings.ids)
  end

  def followers
    @user = current_user
    @followers = User.find(current_user.followers.ids)
  end

  def follow
    @following = User.find(params[:id])
    @following_posts = @following.posts.includes(:taggings).order("created_at DESC").page(params[:page]).per(DEFAULT_PAGE_ITEM_COUNT)
  end

end
