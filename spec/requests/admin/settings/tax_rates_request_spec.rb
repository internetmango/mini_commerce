# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tax_Rates', type: :request do
  let(:tax_rate) { create(:tax_rate) }
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/settings/tax_rates'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/admin/settings/tax_rates/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'redirect to index page' do
      post '/admin/settings/tax_rates', params: { tax_rate: {
        name: 'India',
        rate: 2.8
      } }
      expect(response.location).to include '/admin/settings/tax_rates'
      follow_redirect!
      expect(response.body).to include('India')
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/admin/settings/tax_rates/#{tax_rate.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/admin/settings/tax_rates/#{tax_rate.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'redirect to show page' do
      patch "/admin/settings/tax_rates/#{tax_rate.id}", params: { tax_rate: { name: 'japan' } }
      expect(response.location).to include "/admin/settings/tax_rates/#{tax_rate.id}"
      follow_redirect!
      expect(response.body).to include('japan')
    end
  end

  describe 'DELETE /destroy' do
    it 'redirect to index page' do
      delete "/admin/settings/tax_rates/#{tax_rate.id}"
      expect(response.location).to include '/admin/settings/tax_rates'
      follow_redirect!
      expect(response.body).to include('successfully destroyed')
    end
  end
end
