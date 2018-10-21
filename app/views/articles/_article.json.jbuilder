json.extract! article, :id, :title, :abstract, :content, :url, :slug, :created_at, :updated_at
json.url article_url(article, format: :json)
