# frozen_string_literal: true

module Admin
  module Settings
    class TaxRatesController < AdminController
      include Pagy::Backend
      skip_before_action :verify_authenticity_token, only: [:destroy]
      before_action :set_tax_rate, only: %i[show edit update destroy]
      before_action :authorize_tax_rate, only: %i[show update destroy]
      before_action :authorize_tax_rates, except: %i[show update destroy]

      def index
        @pagy, @tax_rates = pagy(TaxRate.order(updated_at: :desc))
      end

      def new
        @tax_rate = TaxRate.new
      end

      def create
        tax_rate = TaxRate.new(tax_rate_params)
        if tax_rate.save
          redirect_to admin_settings_tax_rates_path,
                      notice: 'Tax rate was successfully created.'
        else
          render :new
        end
      end

      def update
        if @tax_rate.update(tax_rate_params)
          redirect_to admin_settings_tax_rate_path(@tax_rate),
                      notice: 'Tax rate was successfully updated.'
        else
          Rails.logger.info(@tax_rate.errors.messages.inspect)
          render :edit
        end
      end

      def edit; end

      def destroy
        if @tax_rate.destroy
          flash[:success] = 'Tax rate was successfully destroyed'
        else
          flash[:error] = 'Error processing your request.'
        end
        redirect_to admin_settings_tax_rates_path
      end

      private

      def tax_rate_params
        params.require(:tax_rate).permit(
          :name, :rate
        )
      end

      def set_tax_rate
        @tax_rate = TaxRate.find(params[:id])
      end

      def authorize_tax_rate
        authorize @tax_rate
      end

      def authorize_tax_rates
        authorize TaxRate
      end
    end
  end
end
