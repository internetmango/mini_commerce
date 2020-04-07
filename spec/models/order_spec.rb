# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new }
  before { subject.save }

  it 'should have many items' do
    order = Order.reflect_on_association(:items)
    expect(order.macro).to eq(:has_many)
  end

  it 'should group by day' do
    create(:order)
    orders = Order.all
    chart_data = Order.group_by_day(orders)
    expect(chart_data).not_to be_empty
  end
end
