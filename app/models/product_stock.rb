# frozen_string_literal: true

class ProductStock < ApplicationRecord
  belongs_to :product
  validates :product_id, presence: true
  validates :current_stock, presence: true
end
