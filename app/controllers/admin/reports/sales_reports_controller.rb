# frozen_string_literal: true

module Admin
  module Reports
    class SalesReportsController < AdminController
      include Pagy::Backend

      skip_before_action :verify_authenticity_token, only: [:destroy]
      rescue_from 'ActiveRecord::StatementInvalid', with: :invalid

      def index
        @pagy, @orders = pagy(Order.where('created_at >= ?', 1.week.ago))
      end

      def sales_reports
        @pagy, @orders = pagy(Order
          .where(
            'created_at >= :start_date AND created_at <= :end_date',
            {
              start_date: report_params[:start_date],
              end_date: report_params[:end_date]
            }
          ))
        if params[:commit] == 'Get CSV'
          send_data order_report_csv,
                    filename: "Orders-#{report_params[:start_date]}-#{report_params[:end_date]}.csv"
        else
          render :index
        end
      end

      private

      def order_report_csv
        attributes = ['Order number', 'user', 'Status', 'Total amount']
        CSV.generate(headers: true) do |csv|
          csv << attributes
          @orders.each do |array|
            csv << array.attributes.values_at('order_number', 'user_id', 'status', 'total_amount')
          end
        end
      end

      def report_params
        params.require(:report).permit(:start_date, :end_date)
      end

      def invalid(_exception)
        render html: t('admin.order.error_messages.Please_input_a_valid_date')
      end
    end
  end
end
