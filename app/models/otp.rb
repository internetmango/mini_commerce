# frozen_string_literal: true

class Otp < ApplicationRecord
  belongs_to :user

  def self.generate_otp
    '%06d' % rand(1_000_000)
  end
end
