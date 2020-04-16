# frozen_string_literal: true

FactoryBot.define do
  factory :tax_rate do
    name { 'India' }
    rate { '9.99' }
  end
end
