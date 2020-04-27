class CreateWishlistItems < ActiveRecord::Migration[6.0]
  def change
    create_table :wishlist_items do |t|
      t.integer :product_id
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
