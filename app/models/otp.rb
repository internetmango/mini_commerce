# frozen_string_literal: true

class Otp < ApplicationRecord
  scope :expired, -> { where('valid_till < ?', Time.zone.now) }
  belongs_to :user
  validates :code, presence: true

  def self.generate_otp
    '%06d' % rand(1_000_000)
  end

  def expired?
    valid_till < Time.zone.now
  end
end
