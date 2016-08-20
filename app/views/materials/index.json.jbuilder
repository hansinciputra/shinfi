json.array!(@materials) do |material|
  json.extract! material, :id, :name, :purpose, :picture, :quantity
  json.url material_url(material, format: :json)
end
