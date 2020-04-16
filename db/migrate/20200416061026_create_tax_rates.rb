class CreateTaxRates < ActiveRecord::Migration[6.0]
  def change
    create_table :tax_rates do |t|
      t.string :name, null:false
      t.decimal :rate, null: false, precision: 4, scale: 2, required: true

      t.timestamps
    end
  end
end
