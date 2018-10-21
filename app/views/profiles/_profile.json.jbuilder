json.extract! profile, :id, :name, :surename, :user_id, :phone_number, :cellphone_number, :created_at, :updated_at
json.url profile_url(profile, format: :json)
