# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  subject { build(:payment_method) }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a provider' do
    subject.provider = nil
    expect(subject).to_not be_valid
  end
end
