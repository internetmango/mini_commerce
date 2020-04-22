# frozen_string_literal: true

module Api::V1
  class CartsController < ApiController
    before_action :set_order

    def add_item
      # Order is set by set_order, else build new
      @order ||= current_user.orders.build(status: 'cart', deleted_at: nil, token: cart_token)
      current_cart.add_item(
        product_id: order_item_params[:product_id],
        quantity: order_item_params[:quantity]
      )
      render_json(@order)
    end

    def show
      render_json(@order)
    end

    def update
      if cart_params[:shipping_address_id]
        shipping_address = Address.find(cart_params[:shipping_address_id])
        @order.shipping_address = shipping_address
      end
      if cart_params[:billing_address_id]
        billing_address = Address.find(cart_params[:billing_address_id])
        @order.billing_address = billing_address
      end
      if @order.save
        render_json(@order)
      else
        render json: { success: false, message: 'failed to update cart' }
      end
    end

    def finalize
      if @order&.update(status: 'confirmed')
        render_json(@order)
      else
        render json: { success: false, message: @order.errors.full_messages.to_sentance }
      end
    end

    def destroy
      if @order&.update(deleted_at: Time.now)
        render_json(@order)
      else
        render json: { success: false, message: 'cart not found' }
      end
    end

    private

    def render_json(cart = nil)
      if cart
        serializer = OrderSerializer.new(cart)
        render json: serializer
      else
        render json: { success: false }
      end
    end

    def current_cart
      @current_cart ||= ShopingCart.new(order: @order)
    end

    def set_order
      @order = current_user.orders.where(status: 'cart', deleted_at: nil).first
    end

    def cart_params
      params.require(:cart).permit(
        :order_number, :status, :sub_total, :user_id,
        :token, :shipping_address_id, :billing_address_id
      )
    end

    def order_item_params
      params.require(:cart).permit(:product_id, :quantity)
    end

    def cart_token
      @cart_token ||= SecureRandom.hex(8)
    end
  end
end
