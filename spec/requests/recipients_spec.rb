require 'rails_helper'

RSpec.describe 'Recipients', type: :request do
  before { get recipients_path }
  describe 'GET /recipients' do
    it { expect(response).to have_http_status(200) }
  end
end
