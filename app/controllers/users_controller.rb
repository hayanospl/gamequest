class UsersController < ApplicationController
before_action :authenticate_user!, only: [:show]
  def show
    @user = current_user
  end

  def edit
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    # if @user.image.file == nil
    #   @user.save
    # end
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
