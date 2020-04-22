# frozen_string_literal: true

module Api::V1
  # Products controller
  class CartsController < ApiController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :set_cart, only: %i[cart update remove current_cart]
    respond_to :json

    def set_cart
      @order unless (@order = current_user.orders.where(status: 'cart', deleted_at: nil).first)
    end

    def add_cart
      @order ||= current_user.orders.find_or_create_by(
        status: 'cart', token: cart_token, deleted_at: nil
      ) do |order|
        order.sub_total = 0
      end

      current_cart.add_item(
        product_id: add_cart_params['product_id'],
        quantity: add_cart_params['quantity']
      )
      render_json(@order)
    end

    def cart
      if @order
        render_json(@order)
      else
        render_json
      end
    end

    def update
      if @order
        if (shipping_address_id = cart_params[:shipping_address_id]) &&
           Address.find(shipping_address_id)
          @order.shipping_address_id = shipping_address_id
        elsif (billing_address_id = cart_params[:billing_address_id]) &&
              Address.find(billing_address_id)
          @order.billing_address_id = billing_address_id
        end
        @order.save
      end
      render_json(@order)
    end

    def remove
      return unless @order

      @order.deleted_at = Time.now
      @order.save
      render_json(@order)
    end

    def current_cart
      @current_cart ||= ShopingCart.new(order: @order)
    end

    def render_json(carts = nil)
      if carts
        serializer = OrderSerializer.new(carts)
        render json: serializer
      else
        render json: []
      end
    end

    private

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
