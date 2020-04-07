# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mockups', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/mockups'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /search' do
    it 'returns http success' do
      get '/mockups/search'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /category' do
    it 'returns http success' do
      get '/mockups/category'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /cart' do
    it 'returns http success' do
      get '/mockups/cart'
      expect(response).to have_http_status(:success)
    end
  end
end
