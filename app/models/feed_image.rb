class FeedImage < ActiveRecord::Base
  mount_uploader :image, InstagramImageUploader

  scope :latest, -> { order('origin_created_at DESC') }

  def image_url
    image.url
  end
end