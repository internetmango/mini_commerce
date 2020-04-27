# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total_amount { 2500 }
    token { SecureRandom.hex(8) }
    status { 'cart' }
    order_number { 123 }
    payment_method { 'upi' }
  end
end
