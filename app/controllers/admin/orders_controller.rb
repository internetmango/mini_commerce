# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    before_action :authenticate_admin
    before_action :set_order, only: %i[show edit update destroy]
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def all
      @orders = Order.all
    end

    def show; end

    def edit; end

    def update
      if set_order.update(order_params)
        redirect_to admin_orders_path(id: set_order.id),
                    notice: 'Order was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @order.destroy
      redirect_to all_admin_orders_path,
                  notice: 'Order was successfully destroyed.'
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
