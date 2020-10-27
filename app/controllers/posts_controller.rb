class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_my_post, only: [:show, :edit, :update, :destroy]

  def top
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    url = params[:post][:youtube]   
        url = url.last(11)
        @post.youtube = url
      if @post.save
        redirect_to :action => "show", :id => @post.id
      else
        render :new
      end
  end

  def show
    results = Geocoder.search(@post.address)
    @latlng = results.first.coordinates
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to :action => "show", :id => @post.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
      @post.destroy
      redirect_to user_path(current_user.id)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :day, :youtube, :address, :latitude, :longitude, :user_id, :picture)
  end

  def get_my_post
    @post=current_user.posts.find_by(id: params[:id])
    redirect_to :root unless @post
  end

end
