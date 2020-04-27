# frozen_string_literal: true

FactoryBot.define do
  factory :featured_product do
    product_id { 1 }
    listing_type { 'featured' }
  end
end
