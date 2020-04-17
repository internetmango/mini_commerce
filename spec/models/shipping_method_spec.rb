# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingMethod, type: :model do
  subject { create(:shipping_method) }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a code' do
    subject.code = nil
    expect(subject).to_not be_valid
  end

  it 'should have a value_type' do
    subject.value_type = nil
    expect(subject).to_not be_valid
  end

  it 'should have a value' do
    subject.value = nil
    expect(subject).to_not be_valid
  end
end
