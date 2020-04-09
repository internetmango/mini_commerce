# frozen_string_literal: true

FactoryBot.define do
  factory :product_image do
    product_id { 1 }
    main { false }
  end
end
