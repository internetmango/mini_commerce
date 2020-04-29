# frozen_string_literal: true

class Otp < ApplicationRecord
  scope :valid, -> { where('valid_till > ?', Time.zone.now) }
  belongs_to :user
  validates :code, presence: true
  before_save :valid_untill

  def self.generate_otp
    '%06d' % rand(1_000_000)
  end

  def valid_untill
    self.valid_till = 1.hour.from_now
  end

  def self.expired_otps
    where('valid_till <= ?', Time.zone.now)
  end
end
