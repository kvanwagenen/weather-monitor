json.array!(@images) do |image|
  json.extract! image, :id, :time, :position, :url
  json.url image_url(image, format: :json)
end
