json.extract! content, :id, :contentable, :title, :description, :created_at, :updated_at
json.url content_url(content, format: :json)
