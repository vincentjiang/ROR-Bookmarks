workers 2

environment ENV['RAILS_ENV'] || 'production'
 
daemonize true
 
pidfile "/home/deployer/owl42.com/shared/tmp/pids/puma.pid"
stdout_redirect "/home/deployer/owl42.com/shared/log/stdout", "/home/deployer/owl42.com/shared/log/stderr"
 
threads 4, 16
 
bind "unix:///home/deployer/owl42.com/shared/tmp/sockets/puma.sock"
