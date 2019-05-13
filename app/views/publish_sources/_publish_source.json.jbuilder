json.extract! publish_source, :id, :title, :description, :publisher_id, :created_at, :updated_at
json.url publish_source_url(publish_source, format: :json)
