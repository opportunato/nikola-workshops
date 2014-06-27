json.array! @workshops do |workshop|
  json.(workshop, :id, :title, :headline, :description, :program, :price, :buy_link, :start_date, :end_date, :is_published, :created_at)

  json.hosts workshop.hosts do |host|
    json.(host, :id, :name, :link, :description)
    json.image_id host.image.id if host.image.present?
    json.image host.image_url if host.image.present?
  end

  json.videos workshop.videos do |video|
    json.(video, :id, :link)
  end

  json.images workshop.images do |image|
    json.(image, :id)
    json.url image.image.url(:small)
  end
end