task :startup => :environment do
  system( "cd #{Rails.root} && rake resque:work QUEUE='*' COUNT=1" )
end
