rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///home/deploy/kollektiv/shared/tmp/puma/appname-puma.sock"
pidfile "/home/deploy/kollektiv/current/tmp/puma/pid"
state_path "/home/deploy/kollektiv/current/tmp/puma/state"

activate_control_app