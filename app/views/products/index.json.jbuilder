json.array!(@products) do |product|
  json.extract! product, :id, :name, :number, :description, :image_url, :price, :size, :active
  json.url product_url(product, format: :json)
end
