# frozen_string_literal: true

class ProductImage < ApplicationRecord
  has_one_attached :image
  belongs_to :product
end
