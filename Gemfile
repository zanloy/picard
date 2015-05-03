source 'https://rubygems.org'

ruby '2.1.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Use Google OAuth for authentication
gem "omniauth-google-oauth2"

# Detect end user timezone
gem 'detect_timezone_rails'

# Use Puma concurrent web server
gem 'puma'

# Use Slim templates instead of erb
gem 'slim-rails'

# Use bootstrap css (http://getbootstrap.com)
gem 'bootstrap-sass', '~> 3.3.4'

# Use bootstrap-datepicker for date fields
gem 'momentjs-rails', '>= 2.8.1'
gem 'bootstrap3-datetimepicker-rails', '~> 4.0.0'

# Use will_paginate for pagination helpers
gem 'will_paginate', '~> 3.0.5'

# Allow us to set delayed_jobs
gem 'delayed_job_active_record'

# Use foreman for process handling
gem 'foreman'

# Load environment variables from .env files
gem 'dotenv-rails'

# Check password strength
gem 'strong_password', '~> 0.0.3'

# Use simple forms for easy form generation
gem 'simple_form'

# Use jqcloud for word clouds
gem "jqcloud-rails"

group :production do
  gem 'rails_12factor'
end

group :development do
  # Use Thin webserver for development
  gem 'thin'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Deploy with capistrano!
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-file-permissions'
end

group :test, :development do
  # Use RSpec instead of testunit
  gem 'rspec-rails'
  # Test with capybara
  gem 'capybara'
  # Use factory_girl to create mock models for testing
  gem 'factory_girl_rails'
  # Use ffaker gem to generate fake data for testing
  gem 'ffaker'
  # Use guard for continous testing
  gem 'guard-rspec'
  # Display notifications in mac os x
  gem 'ruby_gntp'
  gem 'launchy'
  # Used to truncate databases between tests
  gem 'database_cleaner'
end
