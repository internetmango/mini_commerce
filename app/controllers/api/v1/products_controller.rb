# frozen_string_literal: true

module Api::V1
  # Products controller
  class ProductsController < AdminController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :authenticate_admin
    before_action :set_product, only: %i[show update destroy]
    respond_to :html, :js, :json

    def index
      @products = Product.order(updated_at: :desc)
      render json: @products
    end

    def create
      Product.create!(product_params)
      render json: 'Product was successfully created.'
    end

    def show
      render json: @product
    end

    def update
      if @product.update(product_params)
        render json: 'Product was successfully updated.'
      else
        Rails.logger.info(@product.errors.messages.inspect)
        render :edit
      end
    end

    def destroy
      @product.destroy
      render json: 'Product was successfully destroyed.'
    end

    private

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(
        :name, :description,
        :slug, :price,
        :category, :category_id,
        product_images_attributes: %i[image id _destroy]
      )
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
