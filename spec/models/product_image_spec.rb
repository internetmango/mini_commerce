# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductImage, type: :model do
  let(:img) { File.new(fixture_path + '/mobile.jpeg') }

  before :all do
    @product_image = build(:product_image)
  end

  it 'should have one attached image' do
    @product_image.image
                  .attach(io: File.open(img), filename: 'mobile.jpeg', content_type: 'image/jpg')
    expect(@product_image.image).to be_attached
  end

  it 'should belongs to a product' do
    product_img = ProductImage.reflect_on_association(:product)
    expect(product_img.macro).to eq(:belongs_to)
  end
end
