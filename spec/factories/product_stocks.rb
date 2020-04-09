# frozen_string_literal: true

FactoryBot.define do
  factory :product_stock do
    association :product, factory: :product
    current_stock { 1 }
  end
end
