# frozen_string_literal: true

User.create!(name: 'Admin User', email: 'admin@example.com', password: 'mangointernet', admin: true)
User.create!(name: 'John Doe', email: 'user@example.com', password: 'mangointernet')
User.create!(name: 'Jane Roe', email: 'jane@example.com', password: 'mangointernet')
category = Category.create!(name: 'Phone')
products = Product.create!(
  [
    { category_id: category.id, description: '', name: 'Realme 3', price: 10_000 },
    { category_id: category.id, description: '', name: 'Realme 4', price: 10_000 },
    { category_id: category.id, description: '', name: 'Realme 5', price: 10_000 }
  ]
)
current_user = User.first
cart1 = ShopingCart.new(token: SecureRandom.hex(8))
cart1.add_item(current_user: current_user,product_id: Product.first.id, quantity: 2)

# Upload image
uploader = ImageUploader.new(:store)
image_path = "db/assets/images/seed/"
images = ["#{image_path}vivo 1.jpg","#{image_path}vivo 2.jpg","#{image_path}vivo 3.jpg"]
for image in images
  file = File.new(Rails.root.join(image))
  uploaded_file = uploader.upload(file)
  for product in products
	product.product_images.create! image_data: uploaded_file.to_json
  end
end
