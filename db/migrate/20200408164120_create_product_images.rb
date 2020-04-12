class CreateProductImages < ActiveRecord::Migration[6.0]
  def change
    create_table :product_images do |t|
      t.integer :product_id, required: true
      t.boolean :main, required: true, default: false
      t.text :image_data

      t.timestamps
    end
  end
end
