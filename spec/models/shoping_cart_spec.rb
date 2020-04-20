# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ShopingCart, type: :model do
  let(:current_cart) { ShopingCart.new(token: SecureRandom.hex(8)) }
  let(:product) { create(:product) }
  before :each do
    current_cart.add_item(product_id: product.id, quantity: 5)
  end

  it 'add 5 items' do
    expect(current_cart.order.sub_total).to eq(50_000)
  end

  it 'items count will be 5' do
    expect(current_cart.items_count).to eq(5)
  end

  it 'item quantity will be 5' do
    expect(current_cart.item_quantity(product.id)).to eq(5)
  end

  it 'updated subtotal will be 50000' do
    expect(current_cart.order.sub_total).to eq(50_000)
  end
end
