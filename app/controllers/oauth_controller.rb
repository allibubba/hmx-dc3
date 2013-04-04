class OauthController < ApplicationController
  
  # puts "**********************************"
  # puts CLIENT_ID
  # puts CLIENT_SECRET
  # puts CALLBACK_URL
  # puts BASE_URL 
  # puts "**********************************"

  def start
    fb_auth = FbGraph::Auth.new(CLIENT_ID, CLIENT_SECRET)
    client = fb_auth.client
    client.redirect_uri = CALLBACK_URL

    # redirect user to facebook
    redirect_to client.authorization_uri(
      :scope => [:email, :publish_stream]
    )
  end    
  
  def callback
    
    # puts "//*********************************"
    # puts params[:authenticity_token]
    # puts params[:accessToken]
    # puts params[:userID]
    # puts signed_req.inspect
    # puts "//*********************************"


    client = Facebook.auth(CALLBACK_URL).client
    access_token = params[:accessToken]

    auth = FbGraph::Auth.new(CLIENT_ID, CLIENT_SECRET)
    auth.exchange_token! access_token # Needs fb_graph 2.3.1+
    auth.access_token # => new token

    # location check
    getlocation = FbGraph::Query.new(
      "SELECT current_location FROM user WHERE uid=#{params[:userID]}"
    ).fetch(auth.access_token)

    pp "-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    pp getlocation
    # pp getlocation[0][:current_location][:city]
    # pp getlocation[0][:current_location][:state]
    # pp getlocation[0][:current_location][:country]
    # pp getlocation[0][:current_location][:name]
    pp "-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    # # /location check


    # with exchanged token
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts params[:accessToken]
    puts auth.access_token
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

    fbuser = FbGraph::User.me(auth.access_token).fetch
    #location = fbuser.location ? fbuser.location.name : "#{t :interwebs}"
    if getlocation[0][:current_location].nil?
      location = "#{t :interwebs}"
    else  
      location = getlocation[0][:current_location][:name]
    end  

    if getlocation[0][:current_location].nil? || getlocation[0][:current_location][:country].nil?
      country = 'unknown'
    else  
      country = getlocation[0][:current_location][:country]
    end  

    puts "-=-=-=-=-=-=-=-=-=-="
    puts location
    puts "-=-=-=-=-=-=-=-=-=-="

    # new user? create one
    if User.find_by_fb_id(params[:userID]).nil?
      @user = User.create(
        :name_first => fbuser.first_name,
        :name_last  => fbuser.last_name,
        :email      => fbuser.email,
        :location   => location,
        :country    => country,
        :fb_id      => fbuser.identifier,
        :username   => fbuser.username,
        :usertoken  => auth.access_token.to_s
      ) 
      session[:user_id] = fbuser.identifier
      #render :json => @user.inspect
    else
      u = User.find_by_fb_id(fbuser.identifier)
      u.usertoken = auth.access_token.to_s
      u.save
    end
    
    session[:user_id] = fbuser.identifier
    
    puts "oAuth session -------------------------"
    puts fbuser.identifier
    puts "oAuth session -------------------------"

    #redirect_to :controller => "home", :action => "index"
    render :json => {:success=>true}
  end

end


