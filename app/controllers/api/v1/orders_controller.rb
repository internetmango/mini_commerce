# frozen_string_literal: true

module Api::V1
  # Orders controller
  class OrdersController < AdminController
    
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :authenticate_admin
    before_action :set_order, except: %i[index]
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

    private

    def order_params
      params.require(:order).permit(:order_number, :status, :sub_total, :user_id, :token)
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
