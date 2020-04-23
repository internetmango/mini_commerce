class AddColumnsToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :product_name, :string
    add_column :order_items, :product_price, :decimal, precision: 15, scale: 2
    add_column :order_items, :product_short_description, :text
    add_column :order_items, :product_category, :string
  end
end
