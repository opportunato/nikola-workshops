class AddOriginCreatedAtToFeedImages < ActiveRecord::Migration
  def change
    add_column :feed_images, :origin_created_at, :datetime
  end
end
