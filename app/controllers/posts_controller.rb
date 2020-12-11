class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  #before_action :get_my_post, only: [:show, :edit, :update, :destroy]

  def top
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    url = params[:post][:youtube_url]   
        @post.youtube_url = url
    tag_list = params[:post][:tag_name].split(/[[:blank:]]+/).select(&:present?)
      if @post.save
        @post.save_posts(tag_list)
        redirect_to :action => "show", :id => @post.id
      else
        render :new
      end
  end

  def show
      @post = Post.find(params[:id])
      results = Geocoder.search(@post.address)
      @latlng = results.first.coordinates
      @tag_list = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(" ")
  end
  
  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(/[[:blank:]]+/).select(&:present?)
    if @post.update(post_params)
      @post.save_posts(tag_list)
      redirect_to :action => "show", :id => @post.id
    else
      render :new
    end
  end

  def destroy
      @post.destroy
      redirect_to user_path(current_user.id)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :day, :youtube_url, :address, :latitude, :longitude, :user_id, :genre, :start_time, :image1,:image2,:image3)
  end

  #def get_my_post
    #@post=current_user.posts.find_by(id: params[:id])
    #redirect_to :root unless @post
  #end

end
