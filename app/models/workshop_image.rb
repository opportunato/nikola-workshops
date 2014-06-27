class WorkshopImage < ActiveRecord::Base
  belongs_to :workshop

  mount_uploader :image, WorkshopImageUploader
end