class FeedSyncer
  include Sidekiq::Worker

  def perform
    InstagramFetcher.fetch((FeedImage.last && FeedImage.last.created_at) || 4.weeks.ago)
  end
end