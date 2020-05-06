# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    include Pagy::Backend
    before_action :set_order, except: :index
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def index
      @pagy, @orders = pagy(Order.all.order(deleted_at: :desc).order(user_id: :desc))
    end

    def show; end

    def edit; end

    def update
      if @order.update(order_params)
        redirect_to admin_order_path(@order),
                    notice: 'Order was successfully updated.'
      else
        render :edit
      end
    end

    private

    def order_params
      params.require(:order).permit(:order_number, :status, :total_amount, :user_id, :token)
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
