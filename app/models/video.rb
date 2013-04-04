class Video < ActiveRecord::Base

  belongs_to :user
  # has_many :votes
  belongs_to :track
  validates_presence_of :media_id
  validates_presence_of :youtube_url, :on => :update
  #attr_accessible :cdn_resource, :entry_id, :media_id, :video_type, :status, :track_id, :user_id, :youtube_url, :votes_count
  attr_accessible :media_id, :video_type, :status, :track_id, :user_id, :youtube_url, :votes_count, :winner

  before_create :set_status
  after_create :send_notification_after_create
  after_update :send_notification_after_change


  scope :approved,    where(:status => 'approved').order('created_at DESC')
  scope :pending,     where(:status => 'pending').order('created_at DESC')
  scope :denied,      where(:status => 'denied').order('created_at DESC')

  scope :list_latest,     where("status = ?", "approved").order("created_at DESC")

  scope :is_winner,     where("status = ? AND winner != 0","approved").order("created_at DESC")

  scope :list_winner,     where("status = ? AND winner != 0","approved").order("winner ASC")
  scope :video_popular,   where("status = ? AND votes_count > 0","approved").order("votes_count DESC")
  scope :us, where(:user => {:country => 'United States'}).joins(:user)
  scope :gb, where(:user => {:country => 'United Kingdom'}).joins(:user)
  scope :fr, where(:user => {:country => 'France'}).joins(:user)


  #approved message  
  def send_notification_after_change
    if self.status_changed? and (self.status_change[1] == 'approved')
      
      save_thumb(self.media_id)

      user = self.user
      fbuser = FbGraph::User.me(user.usertoken).fetch
      ## now spam this motherfugger!
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "#{INFLUXIS_IMAGE}/thumbnail_play/thumbplay_#{self.media_id}.png"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      fbuser.feed!(
        :message => Video.human_attribute_name("message"),
        :picture => "#{INFLUXIS_IMAGE}/thumbnail_play/thumbplay_#{self.media_id}.png",
        :link => "#{BASE_URL}/vid/#{self.id}",
        :name => Video.human_attribute_name("name"),
        :description => user.name_first+"'s " + Video.human_attribute_name("description"),
        :caption => Video.human_attribute_name("caption")
      )
      ## refresh fragment cache
      ActionController::Base.new.expire_fragment('videos_latest')
      if Rails.env != 'development' and !user.email.nil?
        Postmail.approved(self).deliver
      end
    elsif self.status_changed? and (self.status_change[1] == 'denied')
      pp "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        pp "User #{user}"
      pp "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            
      if Rails.env != 'development' and !user.email.nil?
        Postmail.denied(self).deliver
      end
    else  
      puts "no publication"
    end
  end

 #created message
 def send_notification_after_create
      user = self.user
      fbuser = FbGraph::User.me(user.usertoken).fetch
        pp "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
          pp fbuser.permissions
          pp fbuser.permissions.include?(:email)
          pp fbuser.permissions.include?(:publish_stream)
        pp "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
              
      if fbuser.permissions.include?(:publish_stream)
        ## now spam this motherfugger!
        fbuser.feed!(
          :message => user.name_first+" "+Video.human_attribute_name("message_create"),
          :picture => "#{BASE_URL}/img/battle_90x90.jpg",
          :link => "#{BASE_URL}",
          :name => Video.human_attribute_name("name"),
          :description => Video.human_attribute_name("description_create"),
          :caption => Video.human_attribute_name("caption")
        )
      end
  end


  def self.bylocale locale

  end

 def self.random video_id
  # second call should pass in first id, so it's not randomly called too
  if video_id
    ids = connection.select_all("SELECT id FROM videos WHERE status='approved' AND id != #{video_id}")
  else
    ids = connection.select_all("SELECT id FROM videos WHERE status='approved'")
  end
  
  id = find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  video = Video.find(id)

 end

 def self.single video_id
  where("id = ?", video_id) + where("id != ?", video_id).order("Rand()").limit(1)
 end

  def vote_status user_id
    if self.votes.where("user_id = ?", user_id).count > 0
      true
    else
      false
    end  
  end


  def self.battle video_one, video_two
    v1 = nil
    v2 = nil
    ret = []
    approved = self.approved
    if video_one
      v1 = approved.select{|v| v.id == video_one.to_i}
      filtered_array = approved.delete_if {|hash| hash["id"] == video_one.to_i}
      filtered_array
    else
      v1 = approved.shuffle
    end
    ret.push(v1[0])
    approved.delete_if {|x| x.id == v1[0].id }
  
    if video_two
      v2 = approved.select{|v| v.id == video_two.to_i}
    else
      approved.select!{|v| v.track_id == v1[0].track_id} 
      approved.shuffle!
      v2 = approved.take(1)
    end
    ret.push(v2[0])
    ret
  end




  private

    def save_thumb media_id
      pp "------------------------------------"
      pp "saving #{media_id}"
      pp "------------------------------------"
      local_path = Rails.root.to_s + '/public/media_thumbs/thumbapp_' + media_id + '.png'
      remote_path = 'http://emgklovf.rtmphost.com/http/thumbnail_app/thumbapp_'+media_id+'.png'

      open(local_path, 'wb') do |file|
        file << open(remote_path, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
      end
    end

    def set_status
      self.status = 'pending'
      self.votes_count = 0
    end

end
