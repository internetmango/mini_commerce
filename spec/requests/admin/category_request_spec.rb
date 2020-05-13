# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category', type: :request do
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/categories'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/categories/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      post '/admin/categories', params: { category: {
        name: 'Tv'
      } }
      expect(response.location).to include '/admin/categories'
      follow_redirect!
      expect(response.body).to include('Tv')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/categories/#{category.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/categories/#{category.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/categories/#{category.id}", params: { category: { name: 'Phone' } }
      expect(response.location).to include "/admin/categories/#{category.id}"
      follow_redirect!
      expect(response.body).to include('Phone')
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/categories/#{category.id}"
      expect(response.location).to include '/admin/categories'
      follow_redirect!
      expect(response.body).to include('successfully destroyed')
    end
  end

  describe 'GET /search' do
    it 'render to index page' do
      create(:category, name: 'vegitables')
      get '/admin/categories/search', params: { q: 'vegitables' }
      expect(response.body).to include('vegitables')
    end
  end
end
