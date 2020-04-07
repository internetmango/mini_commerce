# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:csv_file) { File.new(fixture_path + '/products.csv') }

  before :each do
    create(:category)
    @product = create(:product)
  end

  it 'title should be present' do
    @product.name = nil
    expect(subject).to_not be_valid
  end
  it 'should have  many items' do
    product = Product.reflect_on_association(:category)
    expect(product.macro).to eq(:belongs_to)
  end

  it 'import csv file and create products' do
    Product.import(csv_file)
    expect(Product.all).not_to be_empty
  end

  it 'generate CSV' do
    csv_file = Product.generate_csv
    expect(csv_file).to include 'brand,model'
  end
end
