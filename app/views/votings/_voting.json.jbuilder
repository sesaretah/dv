json.extract! voting, :id, :votable_id, :votable_type, :deadline, :voting_type, :created_at, :updated_at
json.url voting_url(voting, format: :json)
