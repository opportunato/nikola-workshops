json.array! @workshops do |workshop|
  json.(workshop, :id, :title, :headline, :description, :program, :price, :buy_link, :start_date, :end_date, :is_published, :created_at)

  json.hosts workshop.hosts do |host|
    json.(host, :id, :name, :link, :description)
  end
end