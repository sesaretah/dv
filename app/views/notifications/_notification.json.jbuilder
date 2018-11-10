json.extract! notification, :id, :title, :content, :notifiable_id, :notifiable_type, :created_at, :updated_at
json.url notification_url(notification, format: :json)
