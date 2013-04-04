class TabController < ApplicationController
  
  def xbox
    session[:locale] = (params[:locale]) ? params[:locale] : 'en_US'
    render :layout => 'tab', :locals => { :set_locale => params[:locale] }
  end

end