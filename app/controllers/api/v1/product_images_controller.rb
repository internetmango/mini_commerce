# frozen_string_literal: true

module Api::V1
  # Products controller
  class ProductImagesController < ApiController
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :set_product_image, only: %i[show update destroy]
    respond_to :json

    def index
      product_images = ProductImage.order(product_id: :desc)
      render_json(product_images)
    end

    def create
      if Product.find(product_image_params['product_id'])
        product = Product.find(product_image_params['product_id'])
        product_image = product.product_images.new(product_image_params)
        if product_image
          render_json(product_image)
        else
          render_json
        end
      else
        render_json
      end
    end

    def show
      render_json(@product_image)
    end

    def update
      if @product_image.update(product_image_params)
        render_json(@product_image)
      else
        Rails.logger.info(@product_image.errors.messages.inspect)
        render_json
      end
    end

    def destroy
      product_image = @product_image
      if @product_image.destroy
        render_json(product_image)
      else
        render_json
      end
    end

    def render_json(product_images = nil)
      if product_images
        serializer = ProductImageSerializer.new(product_images)
        render json: serializer
      else
        render json: nil
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def product_image_params
      params.require(:product_image).permit(
        :product_id, :main, :image_data, :picture
      )
    end

    def set_product_image
      @product_image = ProductImage.find(params[:id])
    end
  end
end
