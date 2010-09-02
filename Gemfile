source 'http://rubygems.org'

gem 'rails', '3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

gem 'demo-reader', '>= 0.1.2'
gem 'exception_notification', :git => "http://github.com/rails/exception_notification.git"
gem 'gravtastic', '>= 2.1.0'
gem 'haml', '>= 3'
gem 'mysql2'
gem 'paperclip'
gem 'rack'
gem 'will_paginate', '>= 3.0.pre2'

gem 'rmagick', '>= 2', :require => 'RMagick', :group => :development

gem "ruby-debug#{"19" if RUBY_VERSION >= "1.9"}", :group => [:test, :cucumber]

group :test do
  gem 'shoulda'
end

group :cucumber do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'webrat'
  gem 'spork'
  gem 'launchy'
end

