# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    address_line1 { 'MyString' }
    address_line2 { 'MyString' }
    city { 'MyString' }
    zipcode { 'MyString' }
    state { 'MyString' }
    country { 'MyString' }
    phone { 'MyString' }
    user_id { 1 }
    order_id { 1 }
  end
end
