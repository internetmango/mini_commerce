# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.decimal :price, null: false, precision: 15, scale: 2
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
