json.extract! article_source, :id, :title, :description, :created_at, :updated_at
json.url article_source_url(article_source, format: :json)
