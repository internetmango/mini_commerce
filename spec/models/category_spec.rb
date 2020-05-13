# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  before :each do
    @category = build_stubbed(:category)
  end

  it 'name should be present' do
    @category.name = nil
    expect(@category).to_not be_valid
  end

  it 'name should not be too long' do
    @category.name = 'a' * 26
    expect(@category).to_not be_valid
  end

  it 'should have a unique name' do
    Category.create!(name: 'Tv')
    another_category = Category.new(name: 'Tv')

    expect(another_category).to_not be_valid
    expect(another_category.errors[:name]).to include('has already been taken')
  end

  it 'should have many products' do
    category = Category.reflect_on_association(:products)
    expect(category.macro).to eq(:has_many)
  end

  it 'should have many teams' do
    category = Category.reflect_on_association(:products)
    expect(category.macro).to eq(:has_many)
  end

  it 'has one attached image ' do
    subject.image.attach(
      io: File.open(fixture_path + '/mobile.jpeg'),
      filename: 'mobile.jpg', content_type: 'image/jpg'
    )
    expect(subject.image).to be_attached
  end
end
