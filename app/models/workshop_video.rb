class WorkshopVideo < ActiveRecord::Base
  before_validation :update_video_data
  belongs_to :workshop

  validates :link, presence: true, format: { with: //}
  validates :video_id, numericality: true
  validates :video_type, inclusion: { in: %i(vimeo), allow_nil: true }

  def update_video_data
    if is_vimeo?
      self.player_link = vimeo_link
      self.video_id = vimeo_id
      self.video_type = :vimeo
    end
  end

  def is_vimeo?
    link.match(/vimeo\.com\/\d+/)
  end

  def vimeo_link
    "//player.vimeo.com/video/#{vimeo_id}"
  end

  def vimeo_id
    link.match(/vimeo\.com\/(\d+)/)[1].to_i
  end
end