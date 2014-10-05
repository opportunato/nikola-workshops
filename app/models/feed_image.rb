class FeedImage < ActiveRecord::Base
  mount_uploader :image, InstagramImageUploader
end