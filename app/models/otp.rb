# frozen_string_literal: true

class Otp < ApplicationRecord
  belongs_to :user

  def self.generate_otp
    Integer((SecureRandom.random_number(9e5) + 1e5), 10)
end
end
