class HostImageUploader < BaseImageUploader
  version :small do
    process resize_to_fill: [160, 160]
    process convert: 'jpg'
  end
end