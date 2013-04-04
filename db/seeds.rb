# encoding: utf-8
# Autogenerated by the db:seed:dump task
# Do not hesitate to tweak this to your needs

AdminUser.create([
  { :email => "admin@example.com", :encrypted_password => "$2a$10$jjUCB2H/kT604wQOFL8UYu8bPlYZSi72KupVz348plyoLlNS8cQoe", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => "2012-09-20 00:29:10", :sign_in_count => 21, :current_sign_in_at => "2012-10-11 18:19:05", :last_sign_in_at => "2012-10-10 19:41:21", :current_sign_in_ip => "10.1.10.249", :last_sign_in_ip => "10.1.10.240", :created_at => "2012-09-14 17:10:24", :updated_at => "2012-10-11 18:19:05" }
], :without_protection => true )



Facebook.create([
  { :created_at => "2012-09-14 17:11:00", :updated_at => "2012-09-14 17:11:00" }
], :without_protection => true )



Track.create([
  { :format_mpeg => "/tracks/scream.mp3", :artist_name => "Usher", :status => "approved", :created_at => "2012-09-14 17:11:00", :updated_at => "2012-09-21 17:40:31", :title => "Scream", :media => "scream" },
  { :format_mpeg => "/tracks/hustle.mp3", :artist_name => "Van McCoy and the Soul City Symphony", :status => "approved", :created_at => "2012-09-14 17:11:00", :updated_at => "2012-09-21 17:42:01", :title => "The Hustle", :media => "hustle" },
  { :format_mpeg => "/tracks/dougie.mp3", :artist_name => "Cali Swag District", :status => "approved", :created_at => "2012-09-14 17:11:00", :updated_at => "2012-09-21 17:42:33", :title => "Teach Me How To Dougie", :media => "dougie" }
], :without_protection => true )



User.create([
  { :name_first => "demo", :name_last => "user", :encrypted_email => "iztIDgT5gTaw636Tf+NUfwGzT3NCXRPXxTJTiF7gRUo=\n", :fb_id => "100000817086403", :created_at => "2012-09-26 16:52:24", :updated_at => "2012-10-10 18:06:22", :username => "roundhouse.development", :usersecret => nil, :usertoken => "AAACJkcE4gCYBAOd3ciE2Dk0ONY2B1I3SKkawbmGi8ndtOvSSf6xnyhBmbTozY4fK5d6jVPCwUxXG4zOc43ZCE4nT4FIVcRAowqulU0wZDZD", :banned => false, :location => "interwebs", :country => "United States" },
  { :name_first => "QA", :name_last => "Time", :encrypted_email => "9FMQXuXx40lMRATT+Xuy57lw2Fr2tRsHUivqdeK4xjE=\n", :fb_id => "100002968448398", :created_at => "2012-09-27 18:03:32", :updated_at => "2012-09-27 18:03:32", :username => "qatime", :usersecret => nil, :usertoken => "AAACJkcE4gCYBAMlysuaM2grHxPy7yZCFlNkHNiL9bZCfShzK4WcDa48cRbjdr8SgtYxbyjxZA0Stzg9lwB7EOGZAzbLplYQwqP0NERRxLH6ZCdo3N5ZBo7", :banned => false, :location => "Portland, Oregon", :country => "United States" },
  { :name_first => "Hickory", :name_last => "Stick", :encrypted_email => "Hnbm5Zw//cHBvgI+ZazVWGCuBMMSBq/0BjTTPc9YiZU=\n", :fb_id => "100002574691787", :created_at => "2012-10-10 19:38:39", :updated_at => "2012-10-11 18:54:52", :username => "hickory.stick.1", :usersecret => nil, :usertoken => "AAACJkcE4gCYBAFA169XcDSZAP8bY33xXdHvo0t551BFWt9FHp2LQv0LFH80GAq0jlyJ628FrfHqDsdrvgvLJIfrU9rRkwTovkP0iPxQZDZD", :banned => false, :location => "Portland, Oregon", :country => "France" }
], :without_protection => true )



Video.create([
  { :created_at => "2012-09-24 21:26:53", :updated_at => "2012-10-05 16:53:08", :video_type => "webcam", :user_id => 9, :status => "approved", :votes_count => 16, :track_id => 1, :media_id => "4702120030735778160", :youtube_url => "http://www.youtube.com/watch?v=wcLNteez3c4", :winner => 1 },
  { :created_at => "2012-09-24 21:56:19", :updated_at => "2012-10-05 16:53:26", :video_type => "webcam", :user_id => 9, :status => "approved", :votes_count => 7, :track_id => 1, :media_id => "4702113433548570991", :youtube_url => "", :winner => 2 },
  { :created_at => "2012-09-24 21:58:50", :updated_at => "2012-10-05 16:53:42", :video_type => "webcam", :user_id => 9, :status => "approved", :votes_count => 8, :track_id => 1, :media_id => "4702111234743419247", :youtube_url => "http://www.youtube.com/watch?v=wcLNteez3c4", :winner => 0 },
  { :created_at => "2012-10-04 22:50:02", :updated_at => "2012-10-10 22:51:37", :video_type => "webcam", :user_id => 13, :status => "approved", :votes_count => 0, :track_id => 1, :media_id => "4702113433615679858", :youtube_url => "google.com", :winner => 0 },
  { :created_at => "2012-10-11 18:19:39", :updated_at => "2012-10-11 18:19:39", :video_type => "webcam", :user_id => 13, :status => "pending", :votes_count => 0, :track_id => 2, :media_id => "4702121130431955311", :youtube_url => nil, :winner => 0 }
], :without_protection => true )



Vote.create([
  { :user_id => nil, :created_at => nil, :updated_at => nil, :video_id => nil }
], :without_protection => true )


