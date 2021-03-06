# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name, :email, :mobile],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  before_save :ensure_authentication_token
  has_many :addresses, dependent: :destroy
  has_many :orders
  has_many :wishlist_items, dependent: :destroy
  has_many :otps, dependent: :destroy
  validates :mobile, numericality: true, length: { is: 10 }, allow_blank: true, if: :mobile

  def ensure_authentication_token
    self.authentication_token = generate_access_token if authentication_token.blank?
  end

  def regenerate_authentication_token
    self.authentication_token = nil
    ensure_authentication_token
    save
  end

  def generate_otp_and_notify
    otp = Otp.generate_otp
    otps.create!(code: otp, valid_till: 1.hour.from_now)
    status = TextlocalClient.send_otp(mobile, otp) if mobile
    if !mobile || (status == 'failure')
      mail = UserMailer.with(user: self, otp: otp)
                       .login_otp.deliver_now
    end
    return unless !status && !mail.to_s.include?(otp)

    'failure'
  end

  def verify_otp_and_save(otp)
    otp = otps.find_by(code: otp)
    return if otp.nil? || otp.expired?

    otp.verified = true
    otp.save
  end

  private

  def generate_access_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
