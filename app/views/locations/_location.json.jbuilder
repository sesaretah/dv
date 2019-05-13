json.extract! location, :id, :title, :user_id, :longitude, :latidue, :description, :created_at, :updated_at
json.url location_url(location, format: :json)
