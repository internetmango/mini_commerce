# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BannerItems', type: :request do
  let(:banner_item) { create(:banner_item) }
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/banner_items'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/banner_items/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      post '/admin/banner_items', params: { banner_item: {
        title: 'Real me',
        image_url: 'https://imgk.timesnownews.com/story/
      1556453812-Realme_3_pro_0.jpg?tr=w-400,h-300,fo-auto'
      } }
      expect(response.location).to include '/admin/banner_items'
      follow_redirect!
      expect(response.body).to include('Real me')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/banner_items/#{banner_item.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/banner_items/#{banner_item.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/banner_items/#{banner_item.id}", params: { banner_item: { title: 'Apple' } }
      expect(response.location).to include "/admin/banner_items/#{banner_item.id}"
      follow_redirect!
      expect(response.body).to include('Apple')
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/banner_items/#{banner_item.id}"
      expect(response.location).to include '/admin/banner_items'
      follow_redirect!
      expect(response.body).to include('successfully destroyed')
    end
  end
end
