# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_method do
    name { 'Truck' }
    code { 'code123' }
    value_type { 'value_type' }
    value { '9.99' }
  end
end
