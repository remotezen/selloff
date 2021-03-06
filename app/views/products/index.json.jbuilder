json.array!(@products) do |product|
  json.extract! product, :id, :image_url, :minimum_bid, :maximum_bid, :description, :name, :category, :user_id_id
  json.url product_url(product, format: :json)
end
