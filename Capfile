# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/bundler'
#require 'capistrano/crono'
#require 'capistrano/file-permissions'
require 'capistrano/puma'
require 'capistrano/puma/nginx'

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
