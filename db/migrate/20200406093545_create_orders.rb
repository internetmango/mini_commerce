# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :sub_total, precision: 2
      t.string :token
      t.string :status, default: 'cart'
      t.integer :user_id
      t.string :order_number

      t.timestamps
    end
  end
end
