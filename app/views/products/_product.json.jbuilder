json.extract! product, :id, :name, :description, :image, :created_at, :updated_at
json.url product_url(product, format: :json)
json.description product.description.to_s
json.image url_for(product.image)
