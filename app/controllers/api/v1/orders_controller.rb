# frozen_string_literal: true

module Api::V1
  # Orders controller
  class OrdersController < AdminController
    skip_before_action :authenticate_admin
    before_action :authenticate_user_with_api_token
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :set_order, except: %i[index add_cart]
    respond_to :json

    def index
      @orders = Order.all
      render json: @orders
    end

    def show
      render json: @order
    end

    def update
      if @order.update(order_params)
        render json: 'Order was successfully updated.'
      else
        render :edit
      end
    end

    def add_cart
      @current_cart.add_item(
        current_user: current_user,
        product_id: add_cart_params['product_id'], quantity: add_cart_params['quantity']
      )
      order = current_cart.order
      render json: "Order was successfully added to cart.
                    {  id: #{order.id},
                       user_id: #{order.user_id},
                       sub_total: #{order.sub_total},
                       token: #{order.token},
                       status: #{order.status},
                       shipping_address_id: #{order.shipping_address_id},
                       billing_address_id: #{order.billing_address_id},
                       order_number: #{order.order_number}
                     }"
    end

    private

    def order_params
      params.require(:order).permit(:order_number, :status, :sub_total, :user_id, :token)
    end

    def add_cart_params
      params.require(:add_cart).permit(:product_id, :quantity)
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
