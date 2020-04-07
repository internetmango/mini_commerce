# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new(title: 'Furniture') }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not be too long' do
    subject.title = 'a' * 20
    expect(subject).to_not be_valid
  end

  it 'should have a unique name' do
    Category.create!(title: 'Foo')
    another_foo = Category.new(title: 'Foo')

    expect(another_foo).to_not be_valid
    expect(another_foo.errors[:title]).to include('has already been taken')
  end

  it 'should have many products' do
    category = Category.reflect_on_association(:products)
    expect(category.macro).to eq(:has_many)
  end

  it 'should have many teams' do
    category = Category.reflect_on_association(:products)
    expect(category.macro).to eq(:has_many)
  end
end
