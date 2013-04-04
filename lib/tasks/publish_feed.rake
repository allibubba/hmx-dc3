task :publish_feed, :video do |t, args|
  video = args[:video]

  puts "-------------------------------------------------------"
  puts video
  puts "-------------------------------------------------------"
end






# task :publish_feed => :environment do
  # fbuser = FbGraph::User.me(user.usertoken).fetch
  # now spam this motherfugger!
  # fbuser.feed!(
    # :message => "#{t :social_approved_message}",
    # TODO: need to get thumbs from Inflexus
    #:picture => ,
    # :link => "<%=BASE_URL%>vid/#{self.id}",
    # :name => "#{t :social_approved_name}",
    # :description => "#{user.name_first} #{t :social_approved_description}"
  # )
# end

