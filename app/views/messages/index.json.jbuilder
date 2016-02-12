json.array!(@messages) do |message|
  json.extract! message, :id, :postfix_queue_id, :postfix_message_id
  json.url message_url(message, format: :json)
end
