# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use i18n-tasks gem for i18n testing
gem 'i18n-tasks'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc
# Use ActiveModel has_secure_password
gem 'bcrypt'
# Omniauth (Specifying 1.3.1 because 1.4 breaks auth)
gem 'omniauth-oauth2', '~> 1.3.1'
# Use Google OAuth for authentication
gem 'omniauth-google-oauth2'
# Load environment variables from .env files
gem 'dotenv-rails'
# Detect end user timezone
gem 'detect_timezone_rails'
# Use foreman for process handling
gem 'foreman'
# Use Puma concurrent web server
gem 'puma'
# Use Slim templates instead of ERB
gem 'slim-rails'
# Use bootstrap css (http://getbootstrap.com)
gem 'bootstrap-sass', '~> 3.3.4'
# Awesome font?
gem 'font-awesome-sass'
# Easy sign-in with social icons and buttons
gem 'bootstrap-social-rails'
# Use will_paginate for pagination helpers
gem 'will_paginate', '~> 3.0.5'
# Use jquery datetimepicker
gem 'jquery-datetimepicker-rails'
# Allow us to set delayed_jobs
gem 'delayed_job_active_record'
# Use CanCanCan for role based access
gem 'cancancan'
# Generates simple forms (bootstrap compatible)
gem 'simple_form'
# Use Cocoon for dynamic nested forms
gem 'cocoon'
# Use jquery-ui for pretty ui shit
gem 'jquery-ui-rails'
# Pretty alert windows
gem 'sweetalert-rails'
# Override default alerts with sweetalert
gem 'sweet-alert-confirm'
# Use jquery autocomplete to make shit nice
gem 'rails-jquery-autocomplete'
# Check password strength
gem 'strong_password', '~> 0.0.3'
# Use slack-notifier to alert the slack channel of new changes
gem 'slack-notifier'
# Use jqcloud for word clouds
gem "jqcloud-rails"
# Use Crono for scheduled tasks
gem 'crono'
# Use friendly_id for prettier urls
gem 'friendly_id', '~> 5.1.0'
# Use RedCarpet for markdown parsing
gem 'redcarpet'
# Use Paperclip for file attachments
gem 'paperclip', '~> 4.3'
# Use searchkick for search and autocomplete
gem 'searchkick'

group :production do
  gem 'mailgun_rails'
end

group :development do
  gem 'awesome_print'
  # Deploy with capistrano!
  gem 'capistrano', '~> 3.5', require: false
  gem 'capistrano-crono',     require: false
  gem 'capistrano3-puma',     require: false
  gem 'capistrano-rails',     require: false
  gem 'capistrano-rbenv',     require: false
  gem 'capistrano-systemd',   require: false
  #gem 'capistrano-file-permissions', required: false
  # Use guard for continous testing
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'rb-readline'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  # Test with capybara
  gem 'capybara'
  # Use coveralls for code coverage testing
  gem 'coveralls', require: false
  # Used to truncate databases between tests
  gem 'database_cleaner'
  # Use factory_girl to create mock models for testing
  gem 'factory_girl_rails'
  # Use ffaker gem to generate fake data for testing
  gem 'ffaker'
  # Allow you to use save_and_open_page in rspec tests
  gem 'launchy'
  # Display notifications in linux
  gem 'libnotify', require: false
  # Allow you to create mock items in testing
  gem 'rspec-activemodel-mocks'
  # Add RSpec html matchers
  gem 'rspec-html-matchers'
  # Use RSpec instead of testunit
  gem 'rspec-rails'
  # Use sqlite3 for database locally
  gem 'sqlite3'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
  # Display notifications in mac os x
  #gem 'ruby_gntp', require: false
end
