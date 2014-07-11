environment ENV['RAILS_ENV'] || 'production'

bind 'unix:///var/run/puma.sock'
pidfile '/home/deploy/kollektiv/current/tmp/pids/puma.pid'
state_path '/home/deploy/kollektiv/current/tmp/pids/puma.state'

threads 0, 16
