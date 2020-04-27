# frozen_string_literal: true

module Api::V1
  class FeaturedProductsController < ApiController
    def index
      featured_products = FeaturedProduct.all.map do |featured_product|
        Product.find(featured_product.product_id)
      end
      render_json(featured_products)
    end

    private

    def render_json(featured_products = nil)
      if featured_products
        serializer = ProductSerializer.new(featured_products)
        render json: serializer
      else
        render json: nil
      end
    end
  end
end
