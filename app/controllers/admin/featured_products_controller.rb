# frozen_string_literal: true

module Admin
  class FeaturedProductsController < AdminController
    include Pagy::Backend
    skip_before_action :verify_authenticity_token, only: :destroy
    before_action :set_featured_product, only: [:show, :edit, :update, :destroy]
    before_action :authorize_featured_product, only: [:show, :update, :destroy]
    before_action :authorize_featured_products, except: [:show, :update, :destroy]

    def index
      @pagy, @featured_products = pagy(FeaturedProduct.all)
    end

    def new
      @featured_product = FeaturedProduct.new
      @products = Product.all
    end

    def show
      @product = Product.find(@featured_product.product_id)
    end

    def create
      if !FeaturedProduct.where(product_id: featured_product_params[:product_id]).first
        featured_product = FeaturedProduct.new(featured_product_params)
        if featured_product.save
          redirect_to admin_featured_products_path,
                      notice: 'Featured product was successfully created.'
        else
          render :new
        end
      else
        featured_product =
          FeaturedProduct.where(product_id: featured_product_params[:product_id]).first
        redirect_to admin_featured_product_path(featured_product),
                    notice: 'This product is already in the list.'
      end
    end

    def update
      if @featured_product.update(featured_product_params)
        redirect_to admin_featured_product_path(@featured_product),
                    notice: 'Featured product was successfully updated.'
      else
        Rails.logger.info(@product.errors.messages.inspect)
        render :edit
      end
    end

    def edit
      @products = Product.all
    end

    def destroy
      if @featured_product.destroy
        flash[:success] = 'Featured product was successfully destroyed'
      else
        flash[:error] = 'Error processing your request'
      end
      redirect_to admin_featured_products_path
    end

    def search
      if params[:q].present?
        value = params[:q]
        @pagy, @featured_products = pagy(FeaturedProduct.search_by_term(value))
      else
        @featured_products = FeaturedProduct.all
      end
      render :index
    end

    private

    def featured_product_params
      params.require(:featured_product).permit(
        :product_id, :listing_type
      )
    end

    def set_featured_product
      @featured_product = FeaturedProduct.find(params[:id])
    end

    def authorize_featured_product
      authorize @featured_product
    end

    def authorize_featured_products
      authorize FeaturedProduct
    end
  end
end
