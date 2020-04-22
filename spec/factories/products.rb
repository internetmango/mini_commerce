# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'Realme X1' }
    price { 10_000 }
    description { 'Helio P70 AI Processor' }

    association :category, factory: :category
  end
end
