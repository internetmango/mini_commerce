# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true,
                   length: { maximum: 15 },
                   uniqueness: { case_sensitive: false }
end
