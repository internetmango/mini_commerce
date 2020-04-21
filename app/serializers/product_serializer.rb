# frozen_string_literal: true

class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :slug, :price, :category_id, :created_at, :updated_at
end
