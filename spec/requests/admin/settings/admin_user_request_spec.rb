# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin_Users', type: :request do
  let(:user) { create(:user) }
  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/settings/admin_users'
      expect(response).to have_http_status(:success)
    end
  end
end
