class UploadController < ApplicationController

# Host: INFLUXIS_BASE
# Username: emgklovf
# Password: formlikevoltron
# Port: 21
# Protocol: FTP


  def index
    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
    else
      @user = User.first
    end

  end

  def file

    track_id =  params[:track_id]
    video_file =  params[:video_file].original_filename

    #if file is greater than 20MB
    if File.size(params[:video_file].tempfile) > 20971520
      #puts "..............."
      #puts "too big"
      #puts "..............."
      render :json => {:error=>"#{t :error_file_size_upload}"}, :content_type => 'text/plain'
      return false
    else
      #puts '//////////////'
      #puts  File.size(params[:video_file].tempfile)
      #puts '//////////////'
    end
    name = video_file[/.*(?=\..+$)/]
    file_ext = File.extname(video_file).to_s

    ### check extension first
    pp "000000000000000000000000000"
    pp file_ext.downcase
    pp "000000000000000000000000000"
    if file_ext.downcase =~ /.(flv|mpeg|ogv|mp4|m4v|mov)$/

      ### check if file name is unique
      #unique = Video.exists?(["media_id = ?", name])

      #if unique
      #  #puts "file name already taken"
      #  render :json => {:error=>"#{t :error_file_name}"}, :content_type => 'text/plain'
      #else

        source_path =  File.expand_path './public/uploads/'
        #file_path = source_path +"/"+ params[:video_file].original_filename.gsub( /[^a-zA-Z0-9_\.]/, '_')
        new_name = "#{Time.now.to_i}"
        file_path = source_path +"/"+new_name+file_ext
        FileUtils.mv params[:video_file].tempfile.path.to_s, file_path, :force => true


        tmp = File.open(file_path)

        #puts "... FTP'ing"
        #puts file_path
        #puts file_path.inspect
        #puts tmp
        #puts File.basename(file_path)
        #puts "-----------------------------------------------------"



        # resque -----------------------------------------------------------------------------------------
        # Resque.enqueue(VideoUploader,
        #   :file_path => file_path,
        #   :remote_file => new_name+file_ext,
        #   :user_id => session[:user_id],
        #   :track_id => track_id,
        #   :name => "#{Time.now.to_i}"
        # )
        # /resque -----------------------------------------------------------------------------------------
        
        Net::FTP.open('emgklovf.rtmphost.com') do |ftp|
          ftp.passive = true
          ftp.login(user = "emgklovf", passwd = "form like voltron")
          ftp.chdir('/emgklovf_apps/recorder/streams/_definst_/uploads')
          ftp.putbinaryfile(file_path, remotefile = new_name+file_ext)
          ftp.quit()
        end

        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts file_ext
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

        user = User.find_by_fb_id(session[:user_id])
        Video.create(:user_id => user.id, :track_id => track_id, :media_id => new_name, :video_type => 'file')
        File.delete(file_path)

        render :json => {:success=>"#{t :upload_success}"}, :content_type => 'text/plain'

      #end

    else
      render :json => {:error=>"#{t :error_file_type_upload} flv, mpeg, ogv, mp4, m4v or mov"}, :content_type => 'text/plain'
    end
  end

  def complete
  end
end

