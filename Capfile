require 'capistrano/setup'

require 'capistrano/deploy'

require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/rbenv'
require 'capistrano/sidekiq'
require 'whenever/capistrano'
require 'capistrano/sidekiq/monit'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
