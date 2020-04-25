# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeaturedProduct, type: :model do
  subject { build(:featured_product) }

  it 'should have a name' do
    subject.listing_type = nil
    expect(subject).to_not be_valid
  end
end
