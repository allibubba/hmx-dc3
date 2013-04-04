class User < ActiveRecord::Base
  #before_create :set_location
  has_many :videos
  #has_many :votes
  attr_accessible :email, :encrypted_email, :fb_id, :name_first, :name_last, :username, :usersecret, :usertoken, :banned, :location, :country

  attr_encrypted :email, :key => 'MySuperLiciousFreakingAwesomeEncryptionStringBroughtToYouBytheLetter3', :encode => true
  
  def load
    # loads the stored data
  end

  def winners
    n = self.videos.map { |video|  video if video.winner != 0}
    n.delete_if {|x| x.nil? }
  end

  private
    def set_location
      self.location = 'interwebs'
    end
end

