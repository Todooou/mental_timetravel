class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
    @user = User.find(params[:id])
    @post = current_user.posts.all.order(day: :desc)
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
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.fetch(:user, {}).permit(:username,:image)
  end
end
