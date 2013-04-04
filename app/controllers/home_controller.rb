class HomeController < ApplicationController

  def index
    @locale = Locale.all
    video_one ||=(params[:id] || params[:ida]) || nil
    video_two ||=params[:idb] || nil
    @track = Track

    
    @battle = Video.battle(video_one, video_two)

    # tabs
    @list_latest = Video.list_latest
    @list_popular = Video.video_popular
    @is_winner = Video.is_winner
    @list_winner = Video.list_winner


    # puts "WINNER ************************************"
    # puts @is_winner.count
    # puts @list_winner
    # puts "WINNER ************************************"

    if session[:user_id] and User.find_by_fb_id(session[:user_id])

      # puts '-----++++++++++++++'
      # puts session[:user_id]
      # puts '-----++++++++++++++'

      @user = User.find_by_fb_id(session[:user_id])

      @my_videos = @list_latest.select {|i| i.user_id == @user.id }

      #    # check token expiration and request new if needed!
      #    fb_auth = FbGraph::Auth.new('151259104968742', '2e783d93aefa6581e923a62c6054abac')
      #    fb_auth.client # => Rack::OAuth2::Client

      #    # get Facebook's auth cookie in advance using their JS SDK
      #    fb_auth.from_cookie(cookies)
      #    # fb_auth.access_token # => Rack::OAuth2::AccessToken
      #    # fb_auth.user         # => FbGraph::User (only basic attributes)
      #    # fb_auth.user.fetch   # => fetch more details

      #    puts "/*/*/*/*/*/*/*/*/*/*/*/*/*"
      #    puts fb_auth.access_token
      #    puts "/*/*/*/*/*/*/*/*/*/*/*/*/*"

      #    ##try this, rather than getting the user again
      #    # fbuser = fb_auth.user

      fbuser = FbGraph::User.me(@user.usertoken).fetch
      friends = fbuser.friends

      friend_ids = []
      friends.each do |f|
        friend_ids << f.identifier
      end

      @friendvideos = []

      #current_user_friends = User.find_all_by_fb_id(friend_ids)
      current_user_friends = User.where(:fb_id => friend_ids, :banned => false)

      current_user_friends.each do |f|
        @friendvideos << Video.find_by_user_id(f.id)
      end
    else
      # puts '*************************'
      # puts "no session or no user?"
      # puts '*************************'
      @update = true
    end
  end

  ### mobile
  def mobile
    render :layout => "mobile"
  end

  ### destroy session
  def updatesession
    session[:user_id] = params[:user_id]

    # TODO: query user, get friends etc... then update view with content
    # puts "UPDATING .................."
    # puts params[:user_id]
    # puts session[:user_id]
    # puts "UPDATING .................."

    render :json => {:success=>true}
  end

  def destroy
    # Remove the user id from the session
    session[:user_id] = nil
    session[:locale] = nil

    puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    puts session.inspect
    puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    redirect_to root_url
  end

  ### change locale
  def locale
    locales =  Locale.all
    # make sure locale param is an acceptable locale
    session[:locale] = (locales.has_key?(params[:locale].to_sym)) ? params[:locale] : 'en_US'
    puts "-------------------------------------------"
    puts session[:locale]
    puts "-------------------------------------------"
    redirect_to root_url
  end
  ### ajax request partials

  def reloadbattle
    @auto_play = false
    
    if params[:autoplay]
      @auto_play = true
    end
    # puts "AUTOPLAY -------------"
    # puts @auto_play
    # puts "AUTOPLAY -------------"

    respond_to do |format|
      @user = User.find_by_fb_id(session[:user_id])
      @battle = Video.battle(params[:video_id],nil)
      format.html {
        render :partial => 'shared/videobattle', :layout => false, :locals => { :auto_play => @auto_play, :videos => @battle, :flag => true }
      }
      format.js { render action: "reloadbattle", script: true, :locals => { :auto_play => @auto_play} }
    end
  end

  def ajaxrandom
    respond_to do |format|
      list = Video.list_latest
      @list_random = list.sort_by { rand }
      format.html {
        render   :partial => 'shared/videolist', :layout => false, :locals => { :videos => @list_random, :flag => false }
      }
      format.js {
       render action: "ajaxrandom", script: true
      }
    end
  end

  def ajaxpopular
    respond_to do |format|
      @popular = Video.video_popular
      puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
      puts @popular
      puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"      
      format.html {
        render :partial => 'shared/videolist', :layout => false, :locals => { :videos => @popular, :flag => false }
      }
      format.js {
       render action: "ajaxpopular", script: true
      }
    end
  end

  def ajaxmyvideos
    respond_to do |format|
      user = User.find_by_fb_id(session[:user_id])
      @my_videos = user.videos.where(:status => 'approved');
      puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
      puts @my_videos
      puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
      
      format.html {
        render :partial => 'shared/videolist', :layout => false, :locals => { :videos => @my_videos, :flag => false }
      }
      format.js {
       render action: "ajaxmyvideos", script: true
      }
    end
  end

  def ajaxfreindvideos
    @user = User.find_by_fb_id(session[:user_id])
    fbuser = FbGraph::User.me(@user.usertoken).fetch
    friends = fbuser.friends
    friend_ids = []
    friends.each do |f|
      friend_ids << f.identifier
    end
    @friendvideos = []
    current_user_friends = User.where(:fb_id => friend_ids)
    current_user_friends.each do |f|
      #@friendvideos << Video.find_by_user_id(f.id)
      videoset = Video.where(:user_id => f.id, :status => 'approved')
      videoset.each do |robocop|
        @friendvideos << robocop
      end
    end
    pp "/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/"
    pp @friendvideos
    pp "/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/"

    respond_to do |format|
      format.html {
        render :partial => 'shared/videolist',     :layout => false, :locals => { :videos => @friendvideos, :flag => false }
      }
      format.js {
       render action: "ajaxfriendvideos", script: true
      }
    end
  end

  def createvideo
    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
    else
      # puts '/*/*/*/*/*'
      # puts "no session??"
      # puts '/*/*/*/*/*'
    end
  end


  def thanks
    #render :partial => 'home/thanks', :layout => false
    respond_to do |format|
      format.html {
        render :partial => 'home/thanks'
      }
      format.js {
        render :partial => 'home/thanks',     :layout => false
      }
    end    
  end

  def rules
  end

  def faq
  end

  def terms
  end  
end