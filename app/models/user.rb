# user model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  has_many :products
  has_one_attached :avatar

  def self.create_from_provider_data(provider_data)
    email = provider_data.info.email
    where(email: email).first_or_create do |user|
      user.provider = provider_data.provider
      user.uid = provider_data.uid
      user.email = email
      user.password = Devise.friendly_token[0, 20]
      # user.skip_confirmation!
    end
  end

  def admin?
    admin == true
  end
end