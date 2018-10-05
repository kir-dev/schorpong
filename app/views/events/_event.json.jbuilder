json.extract! event, :id, :name, :image, :intro, :content, :application_deadline, :event_date, :created_at, :updated_at
json.url event_url(event, format: :json)
