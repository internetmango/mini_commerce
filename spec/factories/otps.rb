# frozen_string_literal: true

FactoryBot.define do
  factory :otp do
    association :user, factory: :user
    code { '34565' }
    verified { false }
    valid_till { '2020-04-27 15:19:15' }
  end
end
