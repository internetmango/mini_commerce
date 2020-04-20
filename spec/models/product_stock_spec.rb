# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductStock, type: :model do
  let(:product_stock) { build(:product_stock) }

  it 'should have a product id' do
    product_stock.product_id = nil
    expect(product_stock).to_not be_valid
  end

  it 'should have current_stock' do
    product_stock.current_stock = nil
    expect(product_stock).to_not be_valid
  end

  it 'should belongs to a product' do
    product_stock = ProductStock.reflect_on_association(:product)
    expect(product_stock.macro).to eq(:belongs_to)
  end
end
