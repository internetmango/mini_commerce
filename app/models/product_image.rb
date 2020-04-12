# frozen_string_literal: true

class ProductImage < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_one_attached :picture
  belongs_to :product
end
