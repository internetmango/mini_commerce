# frozen_string_literal: true

FactoryBot.define do
  factory :payment_method do
    name { 'debit card' }
    description { 'Nothing' }
    provider { 'razorpay' }
    active { true }
  end
end
