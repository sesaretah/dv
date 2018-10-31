json.extract! tagging_history, :id, :taggable_id, :taggable_type, :target_id, :target_type, :user_id, :revision_number, :article_id, :workflow_transition_id, :created_at, :updated_at
json.url tagging_history_url(tagging_history, format: :json)
