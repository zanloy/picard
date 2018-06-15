# frozen_string_literal: true
# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/bundler'
#require 'capistrano/crono'
#require 'capistrano/file-permissions'

# Puma deployment tasks
require 'capistrano/puma'
install_plugin Capistrano::Puma # Default puma tasks
install_plugin Capistrano::Puma::Nginx # Needed to install nginx template

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
