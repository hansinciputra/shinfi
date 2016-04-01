json.array!(@crafts) do |craft|
  json.extract! craft, :id, :name, :PriceDet_id, :user_id, :category, :price_determinant, :prod_desc, :brand_id, :quantity, :availability
  json.url craft_url(craft, format: :json)
end
