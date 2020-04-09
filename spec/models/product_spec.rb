# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:csv_file) { File.new(fixture_path + '/products.csv') }

  before :all do
    @product = build(:product)
  end

  it 'should have a title' do
    @product.name = nil
    expect(@product).to_not be_valid
  end

  it 'should belongs to a categry' do
    product = Product.reflect_on_association(:category)
    expect(product.macro).to eq(:belongs_to)
  end

  it 'should has many  product images' do
    product = Product.reflect_on_association(:product_images)
    expect(product.macro).to eq(:has_many)
  end

  it 'should import csv file and create products' do
    Product.import(csv_file)
    expect(Product.all).not_to be_empty
  end

  it 'should generate CSV' do
    csv = Product.generate_csv
    expect(csv).to include 'brand,model'
  end
end
