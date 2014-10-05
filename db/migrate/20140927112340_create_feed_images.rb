class CreateFeedImages < ActiveRecord::Migration
  def change
    create_table :feed_images do |t|
      t.string :image
      t.string :instagram_id
      t.string :instagram_link

      t.timestamps
    end
  end
end
