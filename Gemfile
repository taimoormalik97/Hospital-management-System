source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '=6.0.3.2'
# Use mysql as the database for Active Record
gem 'mysql2', '= 0.5.3'
# Use Puma as the app server
gem 'puma', '= 4.3.6'
# Use SCSS for stylesheets
gem 'sass-rails', '= 6.0.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '= 4.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails'
gem 'sequenceid', '=0.0.7', git: "https://github.com/alisyed/sequenceid.git", branch: 'feature/change_activerecord_base_to_applicationrecord_in_sti_parent_class_method'
gem "transitions", :require => ["transitions", "active_model/transitions"]

gem 'jbuilder', '= 2.10.1'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'cancancan', '=3.1.0'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '=1.4.8', require: false

gem 'devise', '=4.7.2'

gem 'breadcrumbs_on_rails', '=4.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry','=0.13.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '= 4.0.4'
  gem 'listen', '= 3.2.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '= 2.1.1'
  gem 'spring-watcher-listen', '= 2.0.1'
end

group :test do
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'rspec-rails','=4.0.1'
  # To create factories while testing
  gem 'factory_girl_rails','=4.9.0', require: false
  # Faker
  gem 'faker','=2.14.0'
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'will_paginate', '=3.1.8'
gem 'will_paginate-bootstrap4', '=0.2.2'
gem 'paperclip', '=6.0.0'
gem 'chartkick', '=3.4.0'
gem 'groupdate', '=5.2.1'
gem 'thinking-sphinx', '=5.0.0'
gem 'validates_timeliness', '=4.1.1'
