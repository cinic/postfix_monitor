FactoryGirl.define do
  factory :recipient do
    address 'test@test.com'
    status 'sent'
    status_raw 'sent (250 2.0.0 Ok: queued as 53C6B1821B6)'
    delivered true
    message_id 1

    factory :recipient_invalid do
      address ''
      status ''
      status_raw ''
      delivered false
      message_id nil
    end
  end
end
