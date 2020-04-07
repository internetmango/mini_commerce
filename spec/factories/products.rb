# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    category_id { 1 }
    name { 'real me' }
    price { 10_000 }
    description { 'Helio P70 AI Processor' }
  end
end
