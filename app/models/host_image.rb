class HostImage < ActiveRecord::Base
  belongs_to :host

  mount_uploader :image, HostImageUploader
end