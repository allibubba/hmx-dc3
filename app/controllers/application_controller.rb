class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'pp'

  layout 'application'
  has_mobile_fu

  before_filter :set_locale, :check_mobile, :authenticate

  def set_locale
    I18n.locale = session[:locale] || params[:locale] || 'en_GB'
  end

  def check_mobile

    if is_mobile_device? && session[:mobile_view] != false
      if request.user_agent.to_s.downcase =~/ipad/
        session[:mobile_ipad] = true
      end
      session[:mobile_view] = true
      render '/home/mobile', :layout => 'mobile' and return
    else
      session[:mobile_view] = false
    end
  end

  protected
  
  def is_facebook?(_ip)
    require "ipaddr"
    low  = IPAddr.new("66.220.144.0").to_i
    high = IPAddr.new("66.220.159.255").to_i
    ip   = IPAddr.new(_ip).to_i
    (low..high)===ip
  end

  def authenticate
    if Rails.env == 'staging' && !is_facebook?(request.remote_ip)
      authenticate_or_request_with_http_basic do |username, password|
        username == "do not use" && password == "do not submit"
      end
    end  
  end

  #def client
  #  @client ||= FBGraph::Client.new(:client_id => CLIENT_ID,
  #                                 :secret_id => CLIENT_SECRET ,
  #                                 :token => session[:access_token])
  #end
end