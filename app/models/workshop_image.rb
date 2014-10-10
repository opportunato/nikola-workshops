class WorkshopImage < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, WorkshopImageUploader
end