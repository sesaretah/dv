json.extract! article_format, :id, :title, :description, :created_at, :updated_at
json.url article_format_url(article_format, format: :json)
