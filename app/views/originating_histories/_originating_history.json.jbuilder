json.extract! originating_history, :id, :article_id, :article_source_id, :originating_id, :revision_number, :user_id, :workflow_transition_id, :created_at, :updated_at
json.url originating_history_url(originating_history, format: :json)
