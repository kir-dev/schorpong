json.extract! membership, :id, :owner, :active, :user_id, :team_id, :created_at, :updated_at
json.url membership_url(membership, format: :json)
