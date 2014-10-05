job_type :sidekiq,  "cd :path && RAILS_ENV=:environment bundle exec sidekiq-client :task :output"

every 1.hour do
  sidekiq "push FeedSyncer"
end