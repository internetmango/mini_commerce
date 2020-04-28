# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  before_save :ensure_authentication_token
  has_many :addresses
  has_many :orders
  has_many :wishlist_items
  has_many :otps

  def ensure_authentication_token
    self.authentication_token = generate_access_token if authentication_token.blank?
  end

  def regenerate_authentication_token
    self.authentication_token = nil
    ensure_authentication_token
    self.save
  end

  def generate_otp_and_notify
    otp = Otp.generate_otp
    otps.create!(code: otp)
    UserMailer.with(user: self, otp: otp).login_otp.deliver_now
  end

  def verify_otp_and_save(otp)
    return unless otps.find_by(code: otp)

    user_otp = otps.find_by(code: otp)
    user_otp.verified = true
    user_otp.save
  end

  private

  def generate_access_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
