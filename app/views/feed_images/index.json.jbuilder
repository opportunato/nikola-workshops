json.array! @feed_images do |image|
  json.(image, :id, :created_at)

  json.link image.image.url(:small)
end