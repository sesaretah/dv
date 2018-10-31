json.extract! upload_history, :id, :uploadable_type, :uploadable_id, :token, :attachment_type, :revision_number, :user_id, :workflow_transition_id, :speaking_id, :created_at, :updated_at
json.url upload_history_url(upload_history, format: :json)
