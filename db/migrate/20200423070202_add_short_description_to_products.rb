class AddShortDescriptionToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :short_description, :text
  end
end
