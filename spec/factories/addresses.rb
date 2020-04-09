# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    association :user, factory: :user
    address_line1 { 'line 1' }
    address_line2 { 'line 2' }
    city { 'city' }
    zipcode { 'zipcode' }
    state { 'state' }
    country { 'country' }
    phone { 'mobile' }
  end
end
