# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductImage, type: :model do
  it 'has one attached image ' do
    subject.picture.attach(
      io: File.open(fixture_path + '/mobile.jpeg'),
      filename: 'mobile.jpg', content_type: 'image/jpg'
    )
    expect(subject.picture).to be_attached
  end

  it 'should belongs to a product' do
    product_img = ProductImage.reflect_on_association(:product)
    expect(product_img.macro).to eq(:belongs_to)
  end
end
