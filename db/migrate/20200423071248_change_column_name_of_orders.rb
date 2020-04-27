class ChangeColumnNameOfOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :sub_total, :total_amount
  end
end
