class WorkshopImageUploader < BaseImageUploader
  version :small do
    process resize_to_limit: [200, nil]
    process convert: 'jpg'
  end

  version :normal do
    process resize_to_limit: [800, nil]
    process convert: 'jpg'
  end
end