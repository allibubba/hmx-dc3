class WebcamController < ApplicationController
  # protect_from_forgery :except => :submit


  def new
    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
      @tracks = Track.all
    end    
  end

  def recorder
    render :partial => 'webcam/recorder', :layout => false, :locals => {:tid => params[:track_id]}
  end
  
  def nocamera
    respond_to do |format|
      format.html {
        render :partial => 'webcam/nocamera'
      }
      format.js {
        render :partial => 'webcam/nocamera',     :layout => false
      }
    end    
  end
  def deniedcamera
    respond_to do |format|
      format.html {
        render :partial => 'webcam/deniedcamera'
      }
      format.js {
        render :partial => 'webcam/deniedcamera',     :layout => false
      }
    end    
  end  

  def submit
    puts "PARAMS Webcam Submit: ************************************"
    puts params[:track_id]
    puts params[:video_id]
    puts "PARAMS Webcam Submit: ************************************"

    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
      
      media = params[:video_id]
      v = Video.create(:video_type => 'webcam', :user_id => @user.id, :media_id => media, :track_id => params[:track_id])
      puts "V: ************************************"
      puts v.inspect
      puts "V: ************************************"      
      "{success : v.media_id}"

    else
      "fail"
    end 
  end

end


