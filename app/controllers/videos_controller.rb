class VideosController < ApplicationController

  def new
    @tracks = Track.all
    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])

      if @user.banned
        redirect_to :controller => "users", :action => "banned"
      end

      @video = Video.new
    else
      "no access"
    end

  end

  def uploadform
    render :partial => 'videos/form', :layout => false
  end

  def upload
    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
      if @user.banned
        redirect_to :controller => "users", :action => "banned"
      end

      @video = Video.new
    else
      "no access"
    end

  end


  def create
    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
      @video = @user.videos.create!(params[:video])
      #redirect_to :action => :show, :id => @video.id
      redirect_to :controller => :home, :action => :thanks, :id => @video.id
    else
      redirect_to :controller => :home, :action => :index
    end
  end

  def share
    @video = Video.find(params[:id])
    render :layout => "share"
  end

  def profile
    # nope, this is depreciated
  end

  def vote
    v = Video.find(params[:id])
      v.increment!(:votes_count)
      v.save
      render :json => {:success=>true, :count=>v.votes_count}
  end

end