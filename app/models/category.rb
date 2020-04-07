# frozen_string_literal: true

# Category class
class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :title, presence: true,
                    length: { maximum: 15 },
                    uniqueness: { case_sensitive: false }
end
