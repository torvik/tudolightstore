json.array!(@orders) do |order|
  json.extract! order, :id, :name, :phone, :email, :address, :delivery_date, :pay_type, :status
  json.url order_url(order, format: :json)
end
