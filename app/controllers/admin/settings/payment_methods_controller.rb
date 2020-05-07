# frozen_string_literal: true

module Admin
  module Settings
    class PaymentMethodsController < AdminController
      include Pagy::Backend
      skip_before_action :verify_authenticity_token, only: [:destroy]
      before_action :set_payment_method, only: %i[show edit update destroy]
      before_action :authorize_payment_method, only: %i[show update destroy]
      before_action :authorize_payment_methods, except: %i[show update destroy]

      def index
        @pagy, @payment_methods = pagy(PaymentMethod.order(updated_at: :desc))
      end

      def new
        @payment_method = PaymentMethod.new
      end

      def show; end

      def create
        payment_method = PaymentMethod.new(payment_method_params)
        if payment_method.save
          redirect_to admin_settings_payment_methods_path,
                      notice: 'Payment method was successfully created.'
        else
          render :new
        end
      end

      def update
        if @payment_method.update(payment_method_params)
          redirect_to admin_settings_payment_method_path(@payment_method),
                      notice: 'Payment method was successfully updated.'
        else
          Rails.logger.info(@payment_method.errors.messages.inspect)
          render :edit
        end
      end

      def edit; end

      def destroy
        if @payment_method.destroy
          flash[:success] = 'Payment method was successfully destroyed'
        else
          flash[:error] = 'Error processing your request'
        end
        redirect_to admin_settings_payment_methods_path
      end

      def search
        if params[:q].present?
          value = params[:q]
          @pagy, @payment_methods = pagy(PaymentMethod.search_by_term(value))
        else
          @payment_methods = PaymentMethod.all
        end
        render :index
      end

      private

      def payment_method_params
        params.require(:payment_method).permit(
          :name, :description,
          :provider, :active
        )
      end

      def set_payment_method
        @payment_method = PaymentMethod.find(params[:id])
      end

      def authorize_payment_method
        authorize @payment_method
      end

      def authorize_payment_methods
        authorize PaymentMethod
      end
    end
  end
end
