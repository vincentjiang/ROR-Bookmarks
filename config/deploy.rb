SSHKit.config.command_map[:rails] = "bundle exec rails"
SSHKit.config.command_map[:rake] = "bundle exec rake"
# config valid only for current version of Capistrano
lock '3.2.1'

set :application, 'bookmark'
set :repo_url, 'git@git.oschina.net:winterbang/BookMark.git'
set :pty, true
set :deploy_via, :remote_cache
set :ssh_options, {
  user: 'winter',
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: false,
  auth_methods: %w(publickey)
}

# rvm
set :rvm_type, :user
set :rvm_ruby_version, '2.1.3'
set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :keep_releases, 12

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets}
namespace :deploy do
  desc 'Setup application'
  task :setup do
    invoke 'nginx:setup'
  end

  desc 'Restart application'
  # task :restart do
  #   invoke 'puma:restart'
  #   invoke 'deploy:update_crontab'
  # end
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  desc "update crotab with whenever"
  task :update_crontab do
    on roles(:all) do
      within release_path do
        execute :bundle, :exec, "whenever --update-crontab #{fetch(:whenever_identifier)} "
      end
    end
  end

  task :rake do
    on roles(:all), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, ENV['task'], "RAILS_ENV=production"
      end
    end
    # cap staging deploy:rake task=add_headimg:seed
  end

  after :restart, :'puma:restart'
  after :restart, :'deploy:update_crontab'
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
end
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

