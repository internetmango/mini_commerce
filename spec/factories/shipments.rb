# frozen_string_literal: true

FactoryBot.define do
  factory :shipment do
    tracking_url { 'MyString' }
    number { 1 }
    order_id { 1 }
    address_id { 1 }
    status { 'MyString' }
  end
end
