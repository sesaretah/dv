json.extract! article_history, :id, :title, :abstract, :content, :url, :document_contents, :created_at, :updated_at
json.url article_history_url(article_history, format: :json)
