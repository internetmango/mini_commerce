# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before :each do
    @user = create(:user)
    sign_in @user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/settings/admin_users'
      expect(response).to have_http_status(:success)
    end
  end
end
