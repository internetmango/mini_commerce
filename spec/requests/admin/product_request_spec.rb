# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:product) { create(:product, name: 'redmi 5') }
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/products'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/products/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      category = Category.create!(name: 'Phone')
      post '/admin/products', params: { product: {
        name: 'nokia',
        category_id: category.id,
        price: 9999
      } }
      expect(response.location).to include '/admin/products'
      follow_redirect!
      expect(response.body).to include('nokia')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/products/#{product.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/products/#{product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/products/#{product.id}", params: { product: { name: 'apple' } }
      expect(response.location).to include "/admin/products/#{product.id}"
      follow_redirect!
      expect(response.body).to include('apple')
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/products/#{product.id}"
      expect(response.location).to include '/admin/products'
      follow_redirect!
      expect(response.body).to include('successfully destroyed')
    end
  end

  describe 'GET /search' do
    it 'render to index page' do
      get '/admin/products/search', params: { q: 'redmi 5' }
      expect(response.body).to include('redmi 5')
    end
  end
end
