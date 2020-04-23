class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.string :name, null:false
      t.text :description
      t.string :provider, null:false
      t.string :code
      t.boolean :active, null:false, default: false

      t.timestamps
    end
  end
end
