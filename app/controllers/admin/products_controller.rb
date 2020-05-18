# frozen_string_literal: true

module Admin
  class ProductsController < AdminController
    include Pagy::Backend
    skip_before_action :verify_authenticity_token, only: :destroy
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :authorize_product, only: [:show, :update, :destroy]
    before_action :authorize_products, except: [:show, :update, :destroy]
    respond_to :csv

    def index
      @pagy, @products = pagy(Product.order(updated_at: :desc))
    end

    def new
      @product = Product.new
      5.times { @product.product_images.build }
    end

    def create
      product = Product.new(product_params)
      if product.save
        redirect_to admin_products_path,
                    notice: 'Product was successfully created.'
      else
        render :new
      end
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
      if @product.destroy
        flash[:success] = 'Product was successfully destroyed'
      else
        flash[:error] = 'Error processing your request'
      end
      redirect_to admin_products_path
    end

    def search
      if params[:q].present?
        value = params[:q]
        @pagy, @products = pagy(Product.search_by_term(value))
      else
        @pagy, @products = pagy(Product.order(updated_at: :desc))
      end
      render :index
    end

    def export_csv
      respond_to do |format|
        format.csv { send_data Product.generate_csv, filename: "products-#{Date.today}.csv" }
      end
    end

    def import_csv; end

    def process_csv
      Product.import(import_params[:file])
      redirect_to admin_products_path
    end

    private

    def product_params
      params.require(:product).permit(
        :name, :description,
        :slug, :price, :short_description,
        :category, :category_id,
        product_images_attributes: %i[image id _destroy picture]
      )
    end

    def import_params
      params.permit(:file)
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def authorize_product
      authorize @product
    end

    def authorize_products
      authorize Product
    end
  end
end
