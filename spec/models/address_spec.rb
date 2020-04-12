# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  before :each do
    @address = build_stubbed(:address)
  end

  it 'should have an address line 1' do
    @address.address_line1 = nil
    expect(@address).to_not be_valid
  end

  it 'should have a city' do
    @address.city = nil
    expect(@address).to_not be_valid
  end

  it 'should have a zipcode' do
    @address.zipcode = nil
    expect(@address).to_not be_valid
  end

  it 'should have a user id' do
    @address.user_id = nil
    expect(@address).to_not be_valid
  end
end
