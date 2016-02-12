require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { FactoryGirl.create :message }
  let(:invalid) { FactoryGirl.build :message_invalid }

  context 'with valid data' do
    it { expect(message).to be_valid }
  end

  context 'with empty data' do
    it { expect(invalid).not_to be_valid }
  end
end
