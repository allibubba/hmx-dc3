class Postmail < ActionMailer::Base
  default from: "dev@roundhouseagency.com"

  def approved(video)
    @video = video
    
    mail(
      :subject  => "#{t :email_subject}",
      :to       => video.user.email,
      :from     => "#{t :email_from}",
      :tag      => 'approved'
    )
  end 

  def denied(video)
    @video = video
    
    mail(
      :subject  => "#{t :email_subject}",
      :to       => video.user.email,
      :from     => "#{t :email_from}",
      :tag      => 'denied'
    )
  end  
  

end
