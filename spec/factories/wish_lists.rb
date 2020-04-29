# frozen_string_literal: true

FactoryBot.define do
  factory :wish_list do
    association :product, factory: :product
    association :user, factory: :user
  end
end
