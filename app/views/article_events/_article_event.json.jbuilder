json.extract! article_event, :id, :title, :description, :created_at, :updated_at
json.url article_event_url(article_event, format: :json)
