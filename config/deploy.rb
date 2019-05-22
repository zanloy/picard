# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '3.10.1'

set :stage, :production

set :application, 'picard'
set :repo_url, 'git@github.com:zanloy/picard.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory
set :deploy_to, '/srv/rails/picard'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Puma and Nginx configuration
# set :puma_bind, %w(tcp://127.0.0.1:5000 unix://#{shared_path}/tmp/sockets/puma.sock)
set :nginx_server_name, 'picard.charlestondigitalhub.com'
set :nginx_ssl_certificate, '/etc/letsencrypt/live/picard.charlestondigitalhub.com/cert.pem'
set :nginx_ssl_certificate_key, '/etc/letsencrypt/live/picard.charlestondigitalhub.com/privkey.pem'
set :nginx_use_ssl, true

set :rbenv_path, '/home/apps/.rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_map_bins, %w[rake gem bundle ruby rails]

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'public/system', 'tmp')
set :linked_files, %w[.env]

# Fix permissions
set :file_permissions_paths, ['/srv/rails/picard/shared']
set :file_permissions_user, 'apps'

namespace :foreman do
  desc 'Export the Procfile to upstart'
  task :export do
    on roles(:app) do
      within release_path do
        execute :sudo, '/home/apps/.rbenv/shims/foreman export systemd /etc/systemd/system -a picard -u apps -l /srv/rails/picard/shared/log'
        execute :sudo, 'systemctl daemon-reload'
      end
    end
  end

  desc 'Start the application services'
  task :start do
    on roles(:app) do
      execute :sudo, 'systemctl start picard.target'
    end
  end

  desc 'Stop the application services'
  task :stop do
    on roles(:app) do
      execute :sudo, 'systemctl stop picard.target'
    end
  end

  desc 'Restart the application services'
  task :restart do
    on roles(:app) do
      execute :sudo, 'systemctl restart picard.target'
    end
  end
end

namespace :deploy do
  task :restart do
    on roles(:app) do
      invoke 'foreman:export'
      # on roles(:app) do
      #   within release_path do
      #     execute :rake, "assets:precompile"
      #   end
      # end
      invoke 'foreman:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # ....
  # @example
  #   bundle exec cap uat deploy:invoke task=users:update_defaults
  desc 'Invoke rake task on the server'
  task :invoke do
    raise 'no task provided' unless ENV['task']

    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, ENV['task']
        end
      end
    end
  end
end
