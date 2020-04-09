# frozen_string_literal: true

User.create!(name: 'Admin User', email: 'admin@example.com', password: 'mangointernet', admin: true)
User.create!(name: 'John Doe', email: 'user@example.com', password: 'mangointernet')
User.create!(name: 'Jane Roe', email: 'jane@example.com', password: 'mangointernet')

category = Category.create!(name: 'Phone')
products = Product.create!(
  [
    { category_id: 1, description: '', name: 'Realme 3', price: 10_000 },
    { category_id: 1, description: '', name: 'Realme 4', price: 10_000 },
    { category_id: 1, description: '', name: 'Realme 5', price: 10_000 }
  ]
)

cart1 = ShopingCart.new(token: SecureRandom.hex(8))
cart1.add_item(product_id: products[1].id, quantity: 2)
