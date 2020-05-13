# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:order) { create(:order) }
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/orders'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/admin/orders'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/orders/#{order.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/orders/#{order.id}", params: { order: { order_number: 'order12343' } }
      expect(response.location).to include "/admin/orders/#{order.id}"
      follow_redirect!
      expect(response.body).to include('order12343')
    end
  end

  describe 'GET /search' do
    it 'render to index page' do
      create(:order, user_id: user.id)
      get '/admin/orders/search', params: { q: '123' }
      expect(response.body).to include('123')
    end
  end
end
