json.extract! contribution_history, :id, :article_id, :role_id, :duty_id, :profile_id, :revision_number, :user_id, :workflow_transition_id, :contribution_id, :created_at, :updated_at
json.url contribution_history_url(contribution_history, format: :json)
