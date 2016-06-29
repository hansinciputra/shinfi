json.array!(@workshops) do |workshop|
  json.extract! workshop, :id, :craft_image, :title, :description, :user_id, :publish_status
  json.url workshop_url(workshop, format: :json)
end
