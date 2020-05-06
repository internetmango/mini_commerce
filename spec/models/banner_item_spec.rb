# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BannerItem, type: :model do
  subject { build(:banner_item) }

  it 'should have a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should have a image url' do
    subject.image_url = nil
    expect(subject).to_not be_valid
  end
end
