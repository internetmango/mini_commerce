# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaxRate, type: :model do
  subject { build(:tax_rate) }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a rate' do
    subject.rate = nil
    expect(subject).to_not be_valid
  end
end
