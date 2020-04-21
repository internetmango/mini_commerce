# frozen_string_literal: true

class ProductImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :product_id, :main, :image_data, :created_at, :updated_at
end
