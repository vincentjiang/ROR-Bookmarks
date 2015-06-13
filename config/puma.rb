workers 2

environment ENV['RAILS_ENV'] || 'production'
 
daemonize true
 
pidfile "/var/www/owl42.com/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/owl42.com/shared/log/stdout", "/var/www/owl42.com/shared/log/stderr"
 
threads 4, 16
 
bind "unix:///var/www/owl42.com/shared/tmp/sockets/puma.sock"
