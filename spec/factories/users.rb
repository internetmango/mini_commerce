# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'adu@g.com' }
    password { 'adu@g.com' }
    admin { true }
  end
end
