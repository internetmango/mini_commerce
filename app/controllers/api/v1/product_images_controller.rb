# frozen_string_literal: true

module Api::V1
  # Products controller
  class ProductImagesController < AdminController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :set_product_image, only: %i[show update destroy]
    respond_to :json

    def index
      @product_images = ProductImage.order(product_id: :desc)
      render json: @product_images
    end

    def create
      product = Product.find(product_image_params['product_id'])
      product_image = product.product_images.new(product_image_params)
      render json: product_image
    end

    def show
      render json: @product_image
    end

    def update
      if @product_image.update(product_image_params)
        render json: @product_image
      else
        Rails.logger.info(@product_image.errors.messages.inspect)
        render :edit
      end
    end

    def destroy
      @product_image.destroy
      render json: 'Product was successfully destroyed.'
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
