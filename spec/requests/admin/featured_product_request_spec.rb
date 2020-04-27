# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FeaturedProduct', type: :request do
  let(:product) { create(:product) }
  let(:featured_product) { create(:featured_product, product_id: product.id) }
  let(:user) { create(:user) }
  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/featured_products'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/featured_products/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      post '/admin/featured_products', params: { featured_product: {
        product_id: product.id
      } }
      expect(response.location).to include '/admin/featured_products'
      follow_redirect!
      expect(response.body).to include('Featured product was successfully created')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/featured_products/#{featured_product.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/featured_products/#{featured_product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/featured_products/#{featured_product.id}",
            params: { featured_product: { listing_type: 'top_selling' } }
      expect(response.location).to include "/admin/featured_products/#{featured_product.id}"
      follow_redirect!
      expect(response.body).to include('top_selling')
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/featured_products/#{featured_product.id}"
      expect(response.location).to include '/admin/featured_products'
    end
  end
end
