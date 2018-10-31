json.extract! speaking_history, :id, :article_id, :language_id, :revision_number, :user_id, :workflow_transition_id, :speaking_id, :created_at, :updated_at
json.url speaking_history_url(speaking_history, format: :json)
