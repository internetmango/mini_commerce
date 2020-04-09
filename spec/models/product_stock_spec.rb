# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductStock, type: :model do
  before :each do
    @product_stock = create(:product_stock)
  end
  it 'should have a product id' do
    @product_stock.product_id = nil
    expect(@product_stock).to_not be_valid
  end

  it 'should have current_stock' do
    @product_stock.current_stock = nil
    expect(@product_stock).to_not be_valid
  end
end
