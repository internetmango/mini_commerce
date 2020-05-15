# frozen_string_literal: true

module Admin
  class DashboardsController < AdminController
  	include Pagy::Backend
    def show
    	@orders_count_today = Order.where('created_at >= ?', 1.day.ago).count
    	@new_users_count_today = User.where('created_at >= ?', 1.day.ago).count
    	@low_stock_count = ProductStock.where('current_stock <= 5').count
    	@pagy, @confirmed_orders_last_5_days = pagy(Order.where('created_at >= ?', 5.days.ago)
    	.where(status: 'confirmed'))
    	@pagy, @incompleted_orders_last_5_days = pagy(Order.where('created_at >= ?', 5.day.ago)
    	.where(status: 'cart'))

    	@new_orders_chart_data = orders_chart(Order.where('created_at >= ?', 1.week.ago))
    	@new_customers_chart_data = orders_chart(User.where('created_at >= ?', 1.week.ago))
    	
    end

    def orders_chart(orders)

	    data = orders.group_by { |order| order.created_at.to_date.strftime('%Y-%m-%d') }
	    chart_data = {}

	    data.each do |date, order|
	      chart_data.merge!({ date => order.count })
	    end
	    p "chart_data : #{chart_data}"
	    chart_data
  	end
  end
end
