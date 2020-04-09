# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipment, type: :model do
  before :each do
    @shipment = create(:shipment)
  end
  it 'should have a number' do
    @shipment.number = nil
    expect(@shipment).to_not be_valid
  end

  it 'should have an order id' do
    @shipment.order_id = nil
    expect(@shipment).to_not be_valid
  end

  it 'should have an address_id' do
    @shipment.address_id = nil
    expect(@shipment).to_not be_valid
  end
end
