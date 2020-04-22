# frozen_string_literal: true

module Api::V1
  # Products controller
  class CartsController < ApiController
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :set_cart, except: %i[add_item render_json]
    respond_to :json

    def add_item
      @order ||= current_user.orders.find_or_create_by(status: 'cart', deleted_at: nil)
      current_cart.add_item(
        product_id: add_cart_params[:product_id],
        quantity: add_cart_params[:quantity]
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

    private

    def set_cart
      @order ||= current_user.orders.where(status: 'cart', deleted_at: nil).first
    end

    def cart_params
      params.require(:cart).permit(
        :order_number, :status, :sub_total, :user_id,
        :token, :shipping_address_id, :billing_address_id
      )
    end

    def add_cart_params
      params.require(:cart).permit(:product_id, :quantity)
    end

    def cart_token
      return @cart_token if @cart_token

      session[:cart_token] ||= SecureRandom.hex(8)
      @cart_token = session[:cart_token]
    end
  end
end
