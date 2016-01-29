json.array!(@prodtypes) do |prodtype|
  json.extract! prodtype, :id
  json.url prodtype_url(prodtype, format: :json)
end
