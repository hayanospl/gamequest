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
    @followings = User.find(current_user.followings.ids)
  end

  def followers
    @followers = User.find(current_user.followers.ids)
  end

  def follow
    @following = User.find(params[:id])
    @following_posts = @following.posts.order("created_at DESC").page(params[:page]).per(10)
  end

end
