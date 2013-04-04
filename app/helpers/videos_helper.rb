module VideosHelper
  
  def generate_name video
    first =  video.user.name_first
    last =  video.user.name_last
    
    if video.user.name_last
      "#{first} #{last[0].chr}."
    else  
      "#{first}."
    end  
  end

end
