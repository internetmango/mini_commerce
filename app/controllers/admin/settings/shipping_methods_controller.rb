# frozen_string_literal: true

module Admin
  module Settings
    class ShippingMethodsController < AdminController
      include Pagy::Backend
      skip_before_action :verify_authenticity_token, only: [:destroy]
      before_action :set_shipping_method, only: %i[show edit update destroy]
      before_action :authorize_shipping_method, only: %i[show update destroy]
      before_action :authorize_shipping_methods, except: %i[show update destroy]

      def index
        @pagy, @shipping_methods = pagy(ShippingMethod.order(updated_at: :desc))
      end

      def new
        @shipping_method = ShippingMethod.new
      end

      def show; end

      def create
        shipping_method = ShippingMethod.new(shipping_method_params)
        if shipping_method.save
          redirect_to admin_settings_shipping_methods_path,
                      notice: 'Shipping method was successfully created.'
        else
          render :new
        end
      end

      def update
        if @shipping_method.update(shipping_method_params)
          redirect_to admin_settings_shipping_method_path(@shipping_method),
                      notice: 'Shipping method was successfully updated.'
        else
          Rails.logger.info(@shipping_method.errors.messages.inspect)
          render :edit
        end
      end

      def edit; end

      def destroy
        if @shipping_method.destroy
          flash[:success] = 'Shipping method was successfully destroyed'
        else
          flash[:error] = 'Error processing your request'
        end
        redirect_to admin_settings_shipping_methods_path
      end

      private

      def shipping_method_params
        params.require(:shipping_method).permit(
          :name, :code,
          :value_type, :value
        )
      end

      def set_shipping_method
        @shipping_method = ShippingMethod.find(params[:id])
      end

      def authorize_shipping_method
        authorize @shipping_method
      end

      def authorize_shipping_methods
        authorize ShippingMethod
      end
    end
  end
end
