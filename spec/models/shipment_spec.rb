# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipment, type: :model do
  let(:shipment) { build(:shipment) }

  it 'should have a number' do
    shipment.number = nil
    expect(shipment).to_not be_valid
  end

  it 'should have an order id' do
    shipment.order_id = nil
    expect(shipment).to_not be_valid
  end

  it 'should have an address_id' do
    shipment.address_id = nil
    expect(shipment).to_not be_valid
  end

  it 'should belongs to address' do
    order = Shipment.reflect_on_association(:address)
    expect(order.macro).to eq(:belongs_to)
  end

  it 'should belongs to order' do
    order = Shipment.reflect_on_association(:order)
    expect(order.macro).to eq(:belongs_to)
  end
end
