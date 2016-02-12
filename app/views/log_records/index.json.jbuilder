json.array!(@log_records) do |log_record|
  json.extract! log_record, :id, :postfix_id, :client, :client_ip, :message_id, :status
  json.url log_record_url(log_record, format: :json)
end
