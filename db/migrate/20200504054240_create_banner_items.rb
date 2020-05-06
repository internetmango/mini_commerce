class CreateBannerItems < ActiveRecord::Migration[6.0]
  def change
    create_table :banner_items do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.json :web_params
      t.json :mobile_params

      t.timestamps
    end
  end
end
