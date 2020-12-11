class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]

  def show
    @user = User.find(params[:id])
    #if @user.id ==current_user.id
    @post = @user.posts.all.order(start_time: :desc)
    #end
    @followers = @user.followers.ids
    @followers_id = @followers.count
    @followings = @user.followings.ids
    @followings_id = @followings.count

  end

  def index
    @user= User.all
  end

  def mypage
    redirect_to user_path(current_user)
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
  
  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  private
  def user_params
    params.fetch(:user, {}).permit(:username,:image)
  end
end