json.extract! content_template, :id, :title, :content, :user_id, :created_at, :updated_at
json.url content_template_url(content_template, format: :json)
