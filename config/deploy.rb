lock '3.2.1'

set :application, 'kollektiv'

set :scm, :git
set :repo_url, 'git@github.com:opportunato/nikola-workshops.git'

set :deploy_to, '/home/deploy/kollektiv'

set :log_level, :info

set :linked_files, %w{config/local_env.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
