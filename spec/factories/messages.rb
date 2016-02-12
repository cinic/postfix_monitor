FactoryGirl.define do
  factory :message do
    postfix_queue_id 'A88BD18214D'
    postfix_message_id '2a44158eaadbd2c062ad5d4dce3ddf64@jar-p.com'
    client 'mail.ilerney.com'
    subject '=?UTF-8?Q?=D0=99=D0=B5=D0=BD=D0=B0=20=D1=81=D1=82=D1=80=D0=B5?=? '\
            '=?UTF-8?Q?=D0=BC=D0=B8=D1=82=D1=81=D1=8F=20=D0=BA=20=D0=BD=D0=BE='\
            'D0=B2?=? =?UTF-8?Q?=D1=8B=D0=BC=20=D0=BC=D0=B0=D0=BA=D1=81=D0'

    factory :message_invalid do
      postfix_queue_id ''
      postfix_message_id ''
      client nil
      subject nil
    end
  end
end
