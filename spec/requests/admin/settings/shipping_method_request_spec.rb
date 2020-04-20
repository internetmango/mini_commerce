# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shipping_Methods', type: :request do
  let(:shipping_method) { create(:shipping_method) }
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/settings/shipping_methods'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/settings/shipping_methods/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      post '/admin/settings/shipping_methods', params: { shipping_method: {
        name: 'Air',
        code: 'code123',
        value_type: 'flat rate',
        value: '9.9'
      } }
      expect(response.location).to include '/admin/settings/shipping_methods'
      follow_redirect!
      expect(response.body).to include('Air')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/settings/shipping_methods/#{shipping_method.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/settings/shipping_methods/#{shipping_method.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/settings/shipping_methods/#{shipping_method.id}",
            params: { shipping_method: { name: 'Air' } }
      expect(response.location).to include "/admin/settings/shipping_methods/#{shipping_method.id}"
      follow_redirect!
      expect(response.body).to include('Air')
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/settings/shipping_methods/#{shipping_method.id}"
      expect(response.location).to include '/admin/settings/shipping_methods'
      follow_redirect!
      expect(response.body).to include('successfully destroyed')
    end
  end
end
