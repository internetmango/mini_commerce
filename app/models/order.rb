# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :items, class_name: 'OrderItem'

  def self.group_by_day(orders)
    data = orders.group_by do |order|
      order.created_at.to_date.strftime('%Y-%m-%d')
    end

    chart_data = {}

    data.each do |date, order|
      chart_data.merge!({ date => order.count })
    end
    chart_data
  end
end
