source 'https://rubygems.org'

gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gemfile in Rails >= 3.1
gem 'activeadmin'
gem "meta_search",    '>= 1.1.0.pre'
gem 'mobile-fu'
gem 'mysql2'
gem 'postmark-rails'
gem 'squeel'

# BACKGROUND TASKS
gem 'redis'
gem 'celluloid', '0.11.0'
gem 'resque', :require => "resque/server"
gem 'slim', '1.3.2'
gem 'sinatra', :require => nil

# need for new Azure VM's
gem 'therubyracer', require: "v8"

# SpaceBook
gem "oauth2"
gem 'fb_graph'
gem "hashie"
gem 'json'
gem 'haml'
gem 'attr_encrypted'
gem 'formtastic',   '~> 2.1.1'

# File uploady thig
gem 'carrierwave'
gem 'carrierwave-ftp', :require => 'carrierwave/storage/ftp/all' # both FTP/SFTP


group :development do
  gem 'thin'
  #gem 'sqlite3'
  gem 'seed_dump'
  gem 'quiet_assets'
end


# debug
# gem 'ruby-debug19'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bourbon'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
