class CreateShippingMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_methods do |t|
      t.string :name, null:false
      t.string :code, null:false
      t.string :value_type, null:false
      t.decimal :value, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
