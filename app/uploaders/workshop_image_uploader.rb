class WorkshopImageUploader < BaseImageUploader
  version :small do
    process resize_to_limit: [320, nil]
    process convert: 'jpg'
  end

  version :small_retina do
    process resize_to_limit: [640, nil]
    process convert: 'jpg'
  end

  version :normal do
    process resize_to_limit: [1600, nil]
    process convert: 'jpg'
  end
end