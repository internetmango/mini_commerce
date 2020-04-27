# frozen_string_literal: true

module Api::V1
  class OrdersController < ApiController
    before_action :set_order, except: :index

    def index
      orders = Order.all
      render_json(orders)
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

    private

    def render_json(orders = nil)
      if orders
        serializer = OrderSerializer.new(orders)
        render json: serializer
      else
        render json: nil
      end
    end

    def order_params
      params.require(:order).permit(:order_number, :status, :total_amount, :user_id, :token)
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
