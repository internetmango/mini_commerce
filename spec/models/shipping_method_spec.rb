# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingMethod, type: :model do
  before :each do
    @shipping_method = create(:shipping_method)
  end

  it 'should have a name' do
    @shipping_method.name = nil
    expect(@shipping_method).to_not be_valid
  end

  it 'should have a code' do
    @shipping_method.code = nil
    expect(@shipping_method).to_not be_valid
  end

  it 'should have a value_type' do
    @shipping_method.value_type = nil
    expect(@shipping_method).to_not be_valid
  end

  it 'should have a value' do
    @shipping_method.value = nil
    expect(@shipping_method).to_not be_valid
  end
end
