json.array! @tags do |tag|
  json.(tag, :id, :name, :created_at)
end