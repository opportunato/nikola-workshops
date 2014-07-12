class WorkshopImageUploader < BaseImageUploader
  version :mobile do
    process resize_to_limit: [640, nil]
    process convert: 'jpg'
  end

  version :tablet do
    process resize_to_limit: [1024, nil]
    process convert: 'jpg'
  end

  version :desktop do
    process resize_to_limit: [1600, nil]
    process convert: 'jpg'
  end
end