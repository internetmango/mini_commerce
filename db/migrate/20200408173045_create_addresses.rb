class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address_line1, required: true
      t.string :address_line2
      t.string :city, required: true
      t.string :zipcode, required: true
      t.string :state
      t.string :country, required: true
      t.string :phone
      t.integer :user_id, required: true
      t.boolean :is_default, null:false, default: false
      t.string :address_type, null:false, default: 'shipping'

      t.timestamps
    end
  end
end
