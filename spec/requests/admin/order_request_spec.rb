# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before :each do
    @order = create(:order)
    user = create(:user)
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
      get "/admin/orders/#{@order.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/orders/#{@order.id}", params: { order: { status: 'order12343' } }
      expect(response).to redirect_to "/admin/orders/#{@order.id}?locale=en"
    end
  end
end
