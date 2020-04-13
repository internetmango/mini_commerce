# frozen_string_literal: true

module Admin
  class ProductsController < AdminController
    include Pagy::Backend
    before_action :autherize_product
    before_action :set_product, except: %i[index new create]
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def index
      @pagy, @products = pagy(Product.order(updated_at: :desc), items: 4)
    end

    def new
      @product = Product.new
      5.times { @product.product_images.build }
    end

    def create
      Product.create!(product_params)
      redirect_to admin_products_path,
                  notice: 'Product was successfully created.'
    end

    def update
      if @product.update(product_params)
        redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
      else
        Rails.logger.info(@product.errors.messages.inspect)
        render :edit
      end
    end

    def edit
      5.times { @product.product_images.build }
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path,
                  notice: 'Product was successfully destroyed.'
    end

    private

    def product_params
      params.require(:product).permit(
        :name, :description,
        :slug, :price,
        :category, :category_id,
        product_images_attributes: %i[image id _destroy picture]
      )
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def autherize_product
      authorize Product
    end
  end
end
