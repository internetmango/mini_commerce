class CreateProductStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :product_stocks do |t|
      t.integer :product_id, required: true
      t.integer :current_stock, required: true, default: 0

      t.timestamps
    end
  end
end
