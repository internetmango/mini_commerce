class CreateTaxRates < ActiveRecord::Migration[6.0]
  def change
    create_table :tax_rates do |t|
      t.string :name, required: true
      t.decimal :rate, precision: 3, scale: 2, required: true

      t.timestamps
    end
  end
end
