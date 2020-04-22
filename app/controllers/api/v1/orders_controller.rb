# frozen_string_literal: true

module Api::V1
  # Orders controller
  class OrdersController < ApiController
    before_action :authenticate_user_with_api_token
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :set_order, except: %i[index add_cart cart]
    respond_to :json

    def index
      @orders = Order.all
      render_json(@orders)
    end

    def show
      render_json(@order)
    end

    def update
      if @order.update(order_params)
        render_json(@order)
      else
        render_json
      end
    end

    def render_json(orders = nil)
      if orders
        serializer = OrderSerializer.new(orders)
        render json: serializer
      else
        render json: []
      end
    end

    private

    def order_params
      params.require(:order).permit(:order_number, :status, :sub_total, :user_id, :token)
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
