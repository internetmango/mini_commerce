# frozen_string_literal: true

User.create!(name: 'Admin User', email: 'admin@example.com', password: 'mangointernet', admin: true)
User.create!(name: 'John Doe', email: 'user@example.com', password: 'mangointernet')
User.create!(name: 'Jane Roe', email: 'jane@example.com', password: 'mangointernet')
