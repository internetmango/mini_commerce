class CreateProductStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :product_stocks do |t|
      t.integer :product_id
      t.integer :current_stock, default: 0

      t.timestamps
    end
  end
end
