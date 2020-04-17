# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaxRate, type: :model do
  before :each do
    @tax_rate = create(:tax_rate)
  end

  it 'should have a title' do
    @tax_rate.name = nil
    expect(@tax_rate).to_not be_valid
  end

  it 'should have a rate' do
    @tax_rate.rate = nil
    expect(@tax_rate).to_not be_valid
  end
end
