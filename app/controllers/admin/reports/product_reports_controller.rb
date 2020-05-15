# frozen_string_literal: true

module Admin
  module Reports
    class ProductReportsController < AdminController
      include Pagy::Backend

      skip_before_action :verify_authenticity_token, only: [:destroy]
      rescue_from 'ActiveRecord::StatementInvalid', with: :invalid

      def index
        @pagy, @product_stocks = pagy(ProductStock
          .where(
            'current_stock <= 5'
          ).order(updated_at: :desc))
      end

      def product_stocks_reports
        if params[:stock].present?
          @pagy, @product_stocks = pagy(ProductStock
          .where(
            'current_stock <= :minimum',
            {
              minimum: params[:stock]
            }
          ).order(updated_at: :desc))
        else
          @pagy, @product_stocks = pagy(ProductStock
          .where(
            'current_stock <= 5'
          ).order(updated_at: :desc))
        end
        render :index
      end

      private

      def invalid(_exception)
        render html: t('admin.order.error_messages.Please_input_a_valid_date')
      end
    end
  end
end
