# frozen_string_literal: true

class Order < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:order_number, :status, :total_amount],
                                   associated_against: {
                                     user: [:name]
                                   },
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  has_many :items, class_name: 'OrderItem', dependent: :destroy
  belongs_to :billing_address, optional: true, class_name: 'Address'
  belongs_to :shipping_address, optional: true, class_name: 'Address'
  belongs_to :user, optional: true
  before_save :set_order_number
  validate :no_existing_cart

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

  def set_order_number
    self.order_number = generate_order_number if order_number.blank?
  end

  def generate_order_number
    loop do
      order_number = "Order#{SecureRandom.hex(3)}"
      break order_number unless Order.where(order_number: order_number).first
    end
  end

  private

  def no_existing_cart
    existing_cart_order = if persisted?
                            Order.where(user_id: user_id, deleted_at: nil, status: 'cart')
                                 .where.not(id: id).first
                          else
                            Order.where(user_id: user_id, deleted_at: nil, status: 'cart').first
                          end
    return unless existing_cart_order

    errors.add(:base, 'Shopping cart already exists for user')
  end
end
