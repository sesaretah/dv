json.extract! vote, :id, :user_id, :voting_id, :outcome, :created_at, :updated_at
json.url vote_url(vote, format: :json)
