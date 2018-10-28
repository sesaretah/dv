json.extract! workflow_transition, :id, :workflow_id, :from_state_id, :to_state_id, :message, :user_id, :role_id, :transition_type, :created_at, :updated_at
json.url workflow_transition_url(workflow_transition, format: :json)
