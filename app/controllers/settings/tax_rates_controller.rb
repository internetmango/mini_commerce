# frozen_string_literal: true

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
      TaxRate.create!(tax_rate_params)
      redirect_to settings_tax_rates_path,
                  notice: 'Tax rate was successfully created.'
    end

    def update
      if @tax_rate.update(tax_rate_params)
        redirect_to settings_tax_rate_path(@tax_rate), notice: 'Tax rate was successfully updated.'
      else
        Rails.logger.info(@tax_rate.errors.messages.inspect)
        render :edit
      end
    end

    def edit
      p "=======edit#{@tax_rate}"
    end

    def destroy
      @tax_rate.destroy
      redirect_to settings_tax_rates_path,
                  notice: 'Tax rate was successfully destroyed.'
    end

    private

    def tax_rate_params
      params.require(:tax_rate).permit(
        :name, :rate
      )
    end

    def set_tax_rate
      @tax_rate = TaxRate.find(params[:id])
      p "=======#{@tax_rate}"
    end

    def authorize_tax_rate
      authorize @tax_rate
    end

    def authorize_tax_rates
      authorize TaxRate
    end
  end
end
