class TagsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @tag = Tag.find(params[:id])
    if @user.id ==current_user.id
    @post = @tag.posts.where(user_id:current_user.id).order(start_time: :desc)
    @tag_list =Tag.joins(:posts).where.not(posts: nil).distinct
    end
  end
end
