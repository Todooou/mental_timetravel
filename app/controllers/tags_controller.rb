class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    followers = current_user.followers.ids
    followings = current_user.followings.ids
    @post = @tag.posts.where(user_id: followers && followings).order(start_time: :desc)
  end
end

