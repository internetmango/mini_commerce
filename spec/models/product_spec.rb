# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:csv_file) { File.new(fixture_path + '/products.csv') }
  let(:product) { create(:product) }

  it 'should have a title' do
    product.name = nil
    expect(product).to_not be_valid
  end

  it 'should belongs to a categry' do
    product = Product.reflect_on_association(:category)
    expect(product.macro).to eq(:belongs_to)
  end

  it 'should has many  product images' do
    product = Product.reflect_on_association(:product_images)
    expect(product.macro).to eq(:has_many)
  end

  it 'should destroy product images on destroying product' do
    product_image_id = product.product_images.create(main: true).id
    product.destroy
    expect { ProductImage.find(product_image_id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'should import csv file and create products' do
    Product.import(csv_file)
    expect(Product.all).not_to be_empty
  end

  it 'should generate CSV' do
    csv = Product.generate_csv
    expect(csv).to include 'brand,model'
  end

  it 'should create a product stock' do
    expect(product.product_stock.product_id).to eq(product.id)
  end

  it 'should destroy product stock on destroying product' do
    product_stock_id = product.product_stock.id
    product.destroy
    expect { ProductStock.find(product_stock_id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
