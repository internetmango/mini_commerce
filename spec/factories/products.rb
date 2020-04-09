# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    association :category, factory: :category
    name { 'Realme X1' }
    price { 10_000 }
    description { 'Helio P70 AI Processor' }
  end
end
