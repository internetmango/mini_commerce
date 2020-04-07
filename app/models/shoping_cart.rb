# frozen_string_literal: true

# custom class
class ShopingCart
  delegate :sub_total, to: :order
  def initialize(token:)
    @token = token
  end

  def order
    @order ||= Order.find_or_create_by(token: @token) do |order|
      order.sub_total = 0
    end
  end

  def add_item(product_id:, quantity:)
    product =  Product.find(product_id)
    order_item = order.items.find_or_initialize_by(product_id: product_id)
    order_item.price = product.price
    order_item.quantity = quantity
    ActiveRecord::Base.transaction do
      order_item.save
      update_subtotal
    end
  end

  def items_count
    order.items.sum(:quantity)
  end

  def item_quantity(product_id)
    product = order.items.find_by(product_id: product_id)
    if product
      product.quantity
    else
      1
    end
  end

  def update_subtotal
    order.sub_total = order.items.sum('quantity*price')
    order.save
  end
end
