class CreateOtps < ActiveRecord::Migration[6.0]
  def change
    create_table :otps do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code, null: false
      t.boolean :verified, null: false, default: false
      t.datetime :valid_till

      t.timestamps
    end
  end
end
