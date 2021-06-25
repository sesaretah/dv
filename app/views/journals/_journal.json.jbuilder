json.extract! journal, :id, :title, :vol, :no, :created_at, :updated_at
json.url journal_url(journal, format: :json)
