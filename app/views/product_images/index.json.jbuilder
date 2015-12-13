json.array!(@product_images) do |product_image|
  json.extract! product_image, :id, :name, :inventory_id
  json.url product_image_url(product_image, format: :json)
end
