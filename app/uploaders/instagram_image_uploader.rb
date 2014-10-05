class InstagramImageUploader < BaseImageUploader
  version :small do
    process resize_to_fill: [320, 320]
    process convert: 'jpg'
  end
end