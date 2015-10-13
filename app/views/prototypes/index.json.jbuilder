json.array!(@prototypes) do |prototype|
  json.extract! prototype, :id, :filename, :directory
  json.url prototype_url(prototype, format: :json)
end
