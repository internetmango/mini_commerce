# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'exampleuser@example.com' }
    password { 'password' }
    admin { true }
  end
end
