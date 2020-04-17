# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before :each do
    @product = create(:product)
    @user = create(:user)
    sign_in @user
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
      category = Category.first.id
      post '/admin/products', params: { product: {
        name: 'nokia',
        category_id: category,
        price: 9999
      } }
      expect(response.location).to include '/admin/products'
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/products/#{@product.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/products/#{@product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/products/#{@product.id}", params: { product: { name: 'apple' } }
      expect(response.location).to include "/admin/products/#{@product.id}"
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/products/#{@product.id}"
      expect(response.location).to include '/admin/products'
    end
  end
end
