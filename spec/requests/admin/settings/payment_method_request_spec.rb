# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payment_Methods', type: :request do
  before :each do
    @payment_method = create(:payment_method)
    user = create(:user)
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/settings/payment_methods'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/settings/payment_methods/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      post '/admin/settings/payment_methods', params: { payment_method: {
        name: 'upi',
        description: 'Nothing',
        provider: 'razorpay',
        active: true
      } }
      expect(response.location).to include '/admin/settings/payment_methods'
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/settings/payment_methods/#{@payment_method.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/settings/payment_methods/#{@payment_method.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/settings/payment_methods/#{@payment_method.id}",
            params: { payment_method: { name: 'upi' } }
      expect(response.location).to include "/admin/settings/payment_methods/#{@payment_method.id}"
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/settings/payment_methods/#{@payment_method.id}"
      expect(response.location).to include '/admin/settings/payment_methods'
    end
  end
end
