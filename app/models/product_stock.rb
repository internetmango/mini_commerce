# frozen_string_literal: true

class ProductStock < ApplicationRecord
  validates :product_id, presence: true
  validates :current_stock, presence: true
end
