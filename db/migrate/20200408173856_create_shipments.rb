class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.string :tracking_url
      t.integer :number, required: true
      t.integer :order_id, required: true
      t.integer :address_id, required: true
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
