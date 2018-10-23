json.extract! upload, :id, :uploadable_type, :uploadable_id, :token, :created_at, :updated_at
json.url upload_url(upload, format: :json)
