environment ENV['RAILS_ENV'] || 'production'

bind 'unix:///home/deploy/kollektiv/shared/tmp/sockets/puma.sock'
pidfile '/home/deploy/kollektiv/current/tmp/pids/puma.pid'
state_path '/home/deploy/kollektiv/current/tmp/states/puma.state'

threads 0, 16
