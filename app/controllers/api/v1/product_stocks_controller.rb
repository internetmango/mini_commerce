# frozen_string_literal: true

module Api::V1
  class ProductStocksController < ApiController
    before_action :set_product_stock, only: [:show, :update, :destroy]

    def index
      product_stocks = ProductStock.order(updated_at: :desc)
      render_json(product_stocks)
    end

    def show
      render_json(@product_stock)
    end

    def update
      if @product_stock.update(product_stock_params)
        render_json(@product_stock)
      else
        Rails.logger.info(@product_stock.errors.messages.inspect)
        render_json
      end
    end

    private

    def render_json(product_stocks = nil)
      if product_stocks
        serializer = ProductStockSerializer.new(product_stocks)
        render json: serializer
      else
        render json: nil
      end
    end

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
