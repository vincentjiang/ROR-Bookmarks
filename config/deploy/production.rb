set :stage, :production

server '182.92.1.13', user: 'bookmark', roles: %w{web app db}
# server '182.92.234.63', user: 'tongxin', roles: %w{web app db}

set :deploy_to, "/opt/project/bookmark"

set :branch, 'master'
set :rails_env, :production

# set :unicorn_worker_count, 5

set :enable_ssl, false

# PUMA
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,   "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix:/opt/project/bookmark/shared/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_init_active_record, false
set :puma_preload_app, true