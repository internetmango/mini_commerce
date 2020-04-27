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

  def self.find_user_by(value)
    where(['mobile = :value OR email = :value', { value: value }]).first
  end

  private

  def generate_access_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
