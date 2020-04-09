# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :user
  validates :address_line1, presence: true,
                            length: { maximum: 100 }
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :country, presence: true
  validates :user_id, presence: true
end
