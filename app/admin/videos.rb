ActiveAdmin.register Video do
  require 'openssl'

  scope :all, :default => true
  scope :approved
  scope :pending
  scope :denied
  scope :us
  scope :gb
  scope :fr

  filter :video_type, :as => :select, :collection => ['webcam','file']
  filter :user
  filter :track
  filter :created_at, :as =>:date_range
  filter :updated_at, :as =>:date_range
  
  if Rails.env.production?
    actions :index, :edit, :update
  end

  member_action :approve, :method => :get do
    v = Video.find(params[:id])
    v.status = 'approved'
    v.save
    flash[:notice] = "Approved!"
    redirect_to :back
  end

  member_action :deny, :method => :get do
    v = Video.find(params[:id])
    v.status = 'denied'
    v.save
    flash[:notice] = "denied!"
    redirect_to :back
  end


  index do
    column "ID", :id
    column "Media ID", :media_id
    column "Type", :video_type
    
    column "Track", :track

    column "User", :user
    column "Email" do |video|
      video.user.email
    end
    # column "Votes", :votes_count
    column "Status", :status
    column "Winner", :winner
    column "votes", :votes_count
    
    # column "status" do |video|
    #   if video.status == 'approved'
    #     link_to 'Deny', deny_admin_video_path(video)
    #   else
    #     link_to 'Approve', approve_admin_video_path(video)
    #   end
    # end    

    default_actions
  end


form :partial => "shared/video_edit", :locals => { :video => @video  }

#  form do |f|
#    f.inputs "Details" do
#      f.input :video_type
#      f.input :status,  :as => :select, :collection => ['approved','denied','pending']
#    end
#    f.inputs "YouTube Link" do
#      f.input :youtube_url
#    end
#    f.inputs "Video" do
#      render :partial => "shared/video_edit", :locals => { :video => @video  }
#    end
#    f.buttons
#  end
  
  show :video_type => :id do |video|
    attributes_table do
      row :video_type
      row :user_id
      row :status
      row :winner
    end

    attributes_table do
      div do
        render :partial => "shared/video_preview", :locals => { :video => video  }
      end
    end

    # div do
    #   if video.status == 'approved'
    #     link_to 'Deny', deny_admin_video_path(video), :class => 'deny_btn status_btn'
    #   else
    #     link_to 'Approve', approve_admin_video_path(video), :class => 'approve_btn status_btn'
    #   end
    # end

    active_admin_comments
  end


end


