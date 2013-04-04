class VideoUploader
  require 'net/ftp'
  
  # @queue = :dc3_stage_video_upload_queue
  @queue = "dc3_#{Rails.env}_video_upload_queue"
  def self.perform(data = {})  


    # CarrierWave.configure do |config|
    #   config.ftp_host = INFLUXIS_BASE
    #   config.ftp_port = 21
    #   config.ftp_user = "emgklovf"
    #   config.ftp_passwd = "form like voltron"
    #   config.ftp_folder = "/emgklovf_apps/recorder/streams/_definst_"
    #   config.ftp_url = "http://#{<%=INFLUXIS_BASE%>}uploads"
    # end
    
    # uploader = FtpUploader.new
    
    # tmp = File.open(data["file_path"])

    # uploader.store!(tmp)



    # trying native FTP
    

    Net::FTP.open(INFLUXIS_BASE) do |ftp|
      ftp.passive = true
      ftp.login(user = "emgklovf", passwd = "form like voltron")
      ftp.chdir('/emgklovf_apps/recorder/streams/_definst_/uploads')
      ftp.putbinaryfile(data["file_path"], remotefile = data["remote_file"])
      ftp.quit()
    end  

    user = User.find_by_fb_id(data["user_id"])
    Video.create(:user_id => user.id, :track_id => data["track_id"], :media_id => data["name"], :video_type => 'file')
    File.delete(data["file_path"])

  end
end