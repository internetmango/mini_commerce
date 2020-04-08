# frozen_string_literal: true

User.create!(name: 'Admin User', email: 'admin@example.com', password: 'mangointernet', admin: true)
User.create!(name: 'John Doe', email: 'user@example.com', password: 'mangointernet')
User.create!(name: 'Jane Roe', email: 'jane@example.com', password: 'mangointernet')
products = [
            { category_id: 1, description: '', name: 'real me 3', price: 10000 },
            { category_id: 1, description: '', name: 'real me 4', price: 10000 },
            { category_id: 1, description: '', name: 'real me 5', price: 10000 }
           ]
if Rails.env.development?
  Category.create(title: 'Phone')
  Product.create!(products)
  @cart_token = SecureRandom.hex(8)
  @current_cart ||= ShopingCart.new(token: @cart_token)
  @current_cart.add_item(product_id: 1, quantity: 5)
end