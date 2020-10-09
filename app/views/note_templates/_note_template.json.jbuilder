json.extract! note_template, :id, :title, :user_id, :created_at, :updated_at
json.url note_template_url(note_template, format: :json)
