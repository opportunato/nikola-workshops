class AddInfoToVideos < ActiveRecord::Migration
  def change
    change_table :workshop_videos do |t|
      t.integer :video_id
      t.string :player_link
      t.string :video_type
    end
  end
end
