app_path = '/home/tornado/postfix_monitor/production/current'

environment 'production'

rackup DefaultRackup

threads 4, 4
workers 1

daemonize false

bind "unix://#{app_path}/tmp/sockets/postfix_monitor.sock"
state_path "#{app_path}/tmp/pids/postfix_monitor.state"
pidfile "#{app_path}/tmp/pids/postfix_monitor.pid"
activate_control_app "unix://#{app_path}/tmp/sockets/postfix_monitor_ctl.sock"
stdout_redirect "#{app_path}/log/puma_access.log",
                "#{app_path}/log/puma_error.log"

preload_app!
