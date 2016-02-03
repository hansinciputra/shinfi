json.array!(@compinfos) do |compinfo|
  json.extract! compinfo, :id, :title, :content, :type, :creator
  json.url compinfo_url(compinfo, format: :json)
end
