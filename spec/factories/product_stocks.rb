# frozen_string_literal: true

FactoryBot.define do
  factory :product_stock do
    product_id { 1 }
    current_stock { 1 }
  end
end
