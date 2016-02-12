require 'rails_helper'

RSpec.describe Recipient, type: :model do
  let(:message) { FactoryGirl.create :message }
  let(:recipient) { FactoryGirl.create :recipient, message_id: message.id }
  let(:invalid) { FactoryGirl.build :recipient_invalid }

  context 'with valid data' do
    it { expect(recipient).to be_valid }
  end

  context 'with empty data' do
    it { expect(invalid).not_to be_valid }
  end
end
