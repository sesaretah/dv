json.extract! typing_history, :id, :article_type_id, :article_id, :typing_id, :revision_number, :user_id, :workflow_transition_id, :created_at, :updated_at
json.url typing_history_url(typing_history, format: :json)
