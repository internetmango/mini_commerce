# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { create(:order) }

  it 'should have many items' do
    object = Order.reflect_on_association(:items)
    expect(object.macro).to eq(:has_many)
  end

  it 'should have one billing_address' do
    object = Order.reflect_on_association(:billing_address)
    expect(object.macro).to eq(:belongs_to)
  end

  it 'should have one shipping_address' do
    object = Order.reflect_on_association(:shipping_address)
    expect(object.macro).to eq(:belongs_to)
  end

  it 'should belongs to a user' do
    object = Order.reflect_on_association(:user)
    expect(object.macro).to eq(:belongs_to)
  end

  it 'should group by day' do
    create(:order)
    orders = Order.all
    chart_data = Order.group_by_day(orders)
    expect(chart_data).not_to be_empty
  end

  it 'should generate order number' do
    prev_order_number = subject.order_number
    expect(subject.generate_order_number).not_to eq(prev_order_number)
  end

  it 'should set order number' do
    expect(subject.order_number).not_to be_empty
  end
end
