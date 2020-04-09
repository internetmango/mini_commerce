class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.belongs_to :order, null: false, foreign_key: true 
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country
      t.string :phone
      t.integer :user_id

      t.timestamps
    end
  end
end
