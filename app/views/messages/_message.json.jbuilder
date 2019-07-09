json.extract! message, :id, :title, :body, :sender_id, :urgency, :created_at, :updated_at
json.url message_url(message, format: :json)
