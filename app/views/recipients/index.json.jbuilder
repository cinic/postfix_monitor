json.array!(@recipients) do |recipient|
  json.extract! recipient, :id, :address, :status, :status_raw, :delivered, :message_id
  json.url recipient_url(recipient, format: :json)
end
