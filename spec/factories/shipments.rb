# frozen_string_literal: true

FactoryBot.define do
  factory :shipment do
    tracking_url { 'tracking url' }
    number { 1 }
    association :order, factory: :order
    association :address, factory: :address
    status { 'pending' }
  end
end
