require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  before { get messages_path }
  describe 'GET /messages' do
    it { expect(response).to have_http_status(200) }
  end
end
