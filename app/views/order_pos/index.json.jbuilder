json.array!(@order_pos) do |order_po|
  json.extract! order_po, :id
  json.url order_po_url(order_po, format: :json)
end
