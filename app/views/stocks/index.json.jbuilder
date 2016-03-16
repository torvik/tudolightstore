json.array!(@stocks) do |stock|
  json.extract! stock, :id, :products_id, :quantity, :active
  json.url stock_url(stock, format: :json)
end
