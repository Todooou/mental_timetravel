class PostsController < ApplicationController
  before_action :authenticate_user!

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
        redirect_to :action => "new"
      end
  end

  def index
    @post = current_user.posts.all.order(day: :desc)
  end

  def show
    @post = Post.find(params[:id])
    results = Geocoder.search(@post.address)
    @latlng = results.first.coordinates
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to :action => "show", :id => @post.id
    else
      redirect_to :action => "new"
    end
  end
  def destroy
    Post.find(params[:id]).destroy
    redirect_to action: :index
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, :day, :youtube, :address, :latitude, :longitude, :user_id, :picture)
  end
end
