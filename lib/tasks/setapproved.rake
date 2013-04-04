task :approve_all => :environment do
  vidoes = Video.all
  vidoes.each do |video|
    video.status = 'approved'
    video.save
  end
end