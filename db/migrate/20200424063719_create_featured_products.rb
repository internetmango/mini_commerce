class CreateFeaturedProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :featured_products do |t|
      t.integer :product_id, null: false
      t.string :listing_type, default: 'featured', null: false


      t.timestamps
    end
  end
end
