json.(report, :id, :slug, :number, :text, :is_published, :workshop_id)

json.workshop_slug report.workshop.slug

if report.has_author?
  author = report.author

  json.author do
    json.(author, :id, :name, :link, :description)
    json.image_id author.image.id if author.image.present?
    json.image author.image_url if author.image.present?
  end
end

json.videos report.videos do |video|
  json.(video, :id, :link)
end

json.images report.images do |image|
  json.(image, :id)
  json.url image.image.url(:mobile)
end