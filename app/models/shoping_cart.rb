# frozen_string_literal: true

class ShopingCart
  delegate :sub_total, to: :order
  attr_reader :order

  ZERO = 0
  private_constant :ZERO

  def initialize(order:)
    @order = order
  end

  def add_item(product_id:, quantity:)
    product = Product.find(product_id)
    order_item = @order.items.find_or_initialize_by(product_id: product_id)
    order_item.price = product.price
    order_item.quantity = quantity
    item_quantity(product_id: product_id)

    ActiveRecord::Base.transaction do
      order_item.save
      update_subtotal_and_save
    end
  end

  def items_count
    @order.items.sum(:quantity)
  end

  def item_quantity(product_id)
    product_item = @order.items.find_by(product_id: product_id)
    return product_item.quantity if product_item

    ZERO
  end

  def update_subtotal_and_save
    @order.sub_total = @order.items.sum('quantity*price')
    @order.save
  end
end
