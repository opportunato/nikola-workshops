lock '3.2.1'

set :application, 'kollektiv'

set :scm, :git
set :repo_url, 'git@github.com:opportunato/nikola-workshops.git'

set :deploy_to, '/home/deploy/kollektiv'

set :log_level, :info

set :linked_files, %w{config/local_env.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 5

set :rbenv_type, :system
set :rbenv_ruby, '2.1.2'
set :rbenv_custom_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :bundle_flags, nil

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
