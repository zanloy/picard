# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.5.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use PostgreSQL as the database for Active Record
gem 'pg', '= 0.21.0' #TODO: once 1.0.0 bug with Rails has been resolved then remove the exact version requirement
# Use i18n-tasks gem for i18n testing
gem 'i18n-tasks'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
# For slack bot to monitor via websocket
gem 'faye-websocket'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc
# Use ActiveModel has_secure_password
gem 'bcrypt'
# Omniauth
gem 'omniauth-oauth2'
# Use Google OAuth for authentication
gem 'omniauth-google-oauth2'
# Use Slack for authentication
#gem 'omniauth-slack', git: 'file:///home/zan/dev/omniauth-slack'
gem 'omniauth-slack', git: 'https://github.com/zanloy/omniauth-slack.git'
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
gem 'bootstrap-sass'
# Awesome font?
gem 'font-awesome-sass'
# Easy sign-in with social icons and buttons
gem 'bootstrap-social-rails'
# Use will_paginate for pagination helpers
gem 'will_paginate'
# Use jquery datetimepicker
gem 'jquery-datetimepicker-rails'
# Allow us to set delayed_jobs
gem 'delayed_job_active_record'
# Use CanCanCan for role based access
gem 'cancancan'
# Generates simple forms (bootstrap compatible)
gem 'simple_form'
# For slack bot
gem 'slack-ruby-bot'
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
gem 'strong_password'
# Use slack-notifier to alert the slack channel of new changes
gem 'slack-notifier'
# Use jqcloud for word clouds
gem "jqcloud-rails"
# Use Crono for scheduled tasks
gem 'crono'
# Use friendly_id for prettier urls
gem 'friendly_id'
# Use RedCarpet for markdown parsing
gem 'redcarpet'
# Use Paperclip for file attachments
gem 'paperclip', '>=5.1.0'
# Use searchkick for search and autocomplete
gem 'searchkick'

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
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :development, :test do
  # Test with capybara
  gem 'capybara'
  # Use capybara-screenshot to get screenshots during rspec tests
  gem 'capybara-screenshot'
  # Use coveralls for code coverage testing
  gem 'coveralls', require: false
  # Used to truncate databases between tests
  gem 'database_cleaner'
  # Used to create mock models for testing
  gem 'factory_bot_rails'
  # Use ffaker gem to generate fake data for testing
  gem 'ffaker'
  # Allow you to use save_and_open_page in rspec tests
  gem 'launchy'
  # Allow you to create mock items in testing
  gem 'rspec-activemodel-mocks'
  # Add RSpec html matchers
  gem 'rspec-html-matchers'
  # Use RSpec instead of testunit
  gem 'rspec-rails'
  # Display notifications in mac os x
  #gem 'ruby_gntp', require: false
  # Use shoulda matchers
  gem 'shoulda-matchers'
end
