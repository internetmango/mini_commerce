# frozen_string_literal: true

module Api::V1
  # Products controller
  class ProductStocksController < AdminController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user_with_api_token
    skip_before_action :authenticate_user!
    before_action :set_product_stock, only: %i[show update destroy]
    respond_to :html, :js, :json

    def index
      @product_stocks = ProductStock.order(updated_at: :desc)
      render json: @product_stocks
    end

    def show
      render json: @product_stock
    end

    def update
      if @product_stock.update(product_stock_params)
        render json: @product_stock
      else
        Rails.logger.info(@product_stock.errors.messages.inspect)
        render :edit
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def product_stock_params
      params.require(:product_stock).permit(
        :product_id, :current_stock
      )
    end

    def set_product_stock
      @product_stock = ProductStock.find(params[:id])
    end
  end
end
