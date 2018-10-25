json.extract! workflow_state, :id, :title, :workflow_id, :created_at, :updated_at
json.url workflow_state_url(workflow_state, format: :json)
