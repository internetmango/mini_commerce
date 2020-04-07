# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    sub_total { 2500 }
    token { SecureRandom.hex(8) }
    status { 'cart' }
    order_number { 123 }
  end
end
