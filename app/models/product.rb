# frozen_string_literal: true

# Products model
class Product < ApplicationRecord
  validates :name, presence: true
  belongs_to :category

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      product = row.to_hash
      category_name = product['category'].capitalize
      category = Category.find_by(title: category_name)
      category ||= Category.create!(title: category_name)
      category_id = category.id

      product['category_id'] = category_id
      product.delete('category')

      Product.create! product
    end
  end

  def self.generate_csv
    attributes =
      %w[brand model description condition title price category image]
    CSV.generate do |csv|
      csv << attributes
    end
  end
end
