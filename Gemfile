source 'https://rubygems.org'

ruby '2.1.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
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

# Use unicorn as the app server
# gem 'unicorn'

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

group :production do
  gem 'rails_12factor'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',        group: :development
end

group :test, :development do
  # Load environment variables from .env files
  gem 'dotenv-rails'
  # Use Thin webserver for development
  gem 'thin'
  # Use RSpec instead of testunit
  gem 'rspec-rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  # Used to truncate databases between tests
  gem 'database_cleaner'
end
